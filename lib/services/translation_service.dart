import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/word_table.dart';

class TranslationService {
  final String apiKey = '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';
  final WordTable wordTable = WordTable();

  Future<void> translateWordsForSingleChapter(int chapterId, String targetLanguage) async {
    print("Starting translation for chapterId: $chapterId, targetLanguage: $targetLanguage");

    // 1. 데이터베이스에서 단어 가져오기
    List<Map<String, dynamic>> wordData = await wordTable.getWordsForChapter(chapterId);
    print("Fetched words: $wordData");

    if (wordData.isEmpty) {
      print('No words found for chapterId: $chapterId');
      return; // 데이터가 없는 경우 종료
    }

    List<String> originalWords = wordData
        .map((data) => data['korean_word'] as String?)
        .where((word) => word != null) // null 값 필터링
        .cast<String>()
        .toList();

    print("Original words for translation: $originalWords");

    if (originalWords.isEmpty) {
      print('No valid words to translate for chapterId: $chapterId');
      return; // 번역할 단어가 없는 경우 종료
    }

    try {
      // 2. 번역 작업 수행
      for (int i = 0; i < originalWords.length; i += 5) {
        List<String> wordsChunk = originalWords.sublist(i, i + 5 > originalWords.length ? originalWords.length : i + 5);
        print("Processing chunk: $wordsChunk");

        List<Map<String, String>> translatedData = await translateAndRomanize(wordsChunk, targetLanguage);
        print("Translated data: $translatedData");

        // 3. 데이터베이스 업데이트
        for (var data in translatedData) {
          print("Updating database for word: ${data['korean_word']}");
          await wordTable.updateWordTranslationByKorean(
            original: data['korean_word']!,
            translated: data['translated_word'] ?? '',
            romanized: data['romanized_word'] ?? '',
          );
        }
      }
    } catch (e) {
      print("Error during translation for chapterId $chapterId: $e");
      throw Exception("Translation failed: $e");
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
        'korean_word': words[i],
        'translated_word': translatedWords[i],
        'romanized_word': romanizedWords[i],
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
