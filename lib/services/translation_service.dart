import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/word_table.dart';

class TranslationService {
  final String apiKey = '';
  final WordTable wordTable = WordTable();

  // 단어를 번역하는 메서드 (챕터별로 수행)
  Future<void> translateAndUpdateWordsByChapter(List<int> chapterIds, String targetLanguage) async {
    // 각 챕터별 단어를 불러와 번역
    for (int chapterId in chapterIds) {
      // 특정 챕터의 모든 단어 불러오기
      List<Map<String, dynamic>> wordData = await wordTable.getWordsForChapter(chapterId);
      List<String> originalWords = wordData.map((data) => data['korean_word'] as String).toList();

      // 5개씩 그룹화하여 번역 및 로마자 표기 진행
      for (int i = 0; i < originalWords.length; i += 5) {
        List<String> wordsChunk = originalWords.sublist(i, i + 5 > originalWords.length ? originalWords.length : i + 5);

        // 번역 및 로마자 표기
        List<Map<String, String>> translatedData = await translateAndRomanize(wordsChunk, targetLanguage);

        // word_table 업데이트
        for (var data in translatedData) {
          await wordTable.updateWordTranslationByKorean(
            original: data['original']!,
            translated: data['translated']!,
            romanized: data['romanized']!,
          );
        }
      }
    }
  }

  // 단어를 번역하고 로마자로 표기하는 메서드
  Future<List<Map<String, String>>> translateAndRomanize(List<String> words, String targetLanguage) async {
    // 1. 번역을 위한 Prompt 생성
    final translationPrompt =
        "Translate the following Korean words into $targetLanguage and provide them as a comma-separated list:\n${words.join(', ')}";

    // 2. 번역 API 호출
    final translatedWords = await _callGPTAPI(translationPrompt);

    // 3. 로마자 표기를 위한 Prompt 생성
    final romanizationPrompt = """
Translate the following words into Romanization in a way that someone who only knows how to read the American English alphabet can understand.
Ensure that the Romanization accurately reflects the pronunciation of each word without additional formatting or context.
Return only the Romanized results as a comma-separated list without any brackets or other characters:
${translatedWords.join(', ')}
""";

    // 4. 로마자 표기 API 호출
    final romanizedWords = await _callGPTAPI(romanizationPrompt);

    // 5. 번역 및 로마자 데이터를 매핑
    List<Map<String, String>> results = [];
    for (int i = 0; i < words.length; i++) {
      results.add({
        'original': words[i],
        'translated': translatedWords[i],
        'romanized': romanizedWords[i],
      });
    }

    return results;
  }

  // GPT API 호출 메서드
  Future<List<String>> _callGPTAPI(String prompt) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final responseText = data['choices'][0]['message']['content'] as String;
      return responseText.split(',').map((word) => word.trim()).toList();
    } else {
      print('GPT API 호출 실패. 상태 코드: ${response.statusCode}');
      print('응답 내용: ${utf8.decode(response.bodyBytes)}');
      throw Exception('GPT API 호출 실패');
    }
  }
}
