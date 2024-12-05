import 'package:flutter/material.dart';
import '../data/chapter_model.dart';
import '../data/word_table.dart';
import 'package:lanny_program/learning/chapter_screen1.dart';

class ChapterCoverPage extends StatefulWidget {
  final int chapterIndex;
  final ChapterModel chapter;

  ChapterCoverPage({required this.chapterIndex, required this.chapter});

  @override
  _ChapterCoverPageState createState() => _ChapterCoverPageState();
}

class _ChapterCoverPageState extends State<ChapterCoverPage> {
  final WordTable wordTable = WordTable(); // 단어 테이블 인스턴스 생성
  List<Map<String, dynamic>> wordList = []; // 단어 데이터를 저장하는 리스트
  bool isLoading = true; // 로딩 상태를 나타내는 플래그

  @override
  void initState() {
    super.initState();
    _loadWords(); // 단어 데이터를 로드하는 함수 호출
  }

  Future<void> _loadWords() async {
    print("Loading words for chapterId: ${widget.chapter.chapterId}");

    try {
      final words = await wordTable.getWordsForChapter(widget.chapter.chapterId);
      print("Loaded words: $words");

      setState(() {
        wordList = words; // 로드된 단어 데이터를 상태에 저장
        isLoading = false; // 로딩 완료
      });
    } catch (e) {
      print('Error loading words for chapter: ${widget.chapter.chapterId}, $e');
      setState(() {
        isLoading = false; // 로딩 중단
      });
    }
  }

  Widget _buildWordCard(Map<String, dynamic> word) {
    // 단어 데이터를 카드 형태로 표시
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: word['word_img'] != null
            ? Image.asset(
          word['word_img'],
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        )
            : Icon(Icons.image, size: 50), // 이미지가 없는 경우 기본 아이콘 표시
        title: Text(
          word['translated_word'] ?? '', // 번역된 단어 표시
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          word['romanized_word'] ?? '', // 로마자 표기 표시
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget _getChapterScreen() {
    // 학습 화면으로 이동
    return ChapterScreen1(chapterId: widget.chapter.chapterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapter.chapterName), // 선택된 챕터 이름을 제목으로 표시
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(), // 뒤로 가기 버튼
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chapter.chapterName, // 챕터 이름
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(widget.chapter.chapterDescription), // 챕터 설명
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator()) // 로딩 중 표시
                : wordList.isEmpty
                ? Center(child: Text("단어 데이터가 없습니다.")) // 단어 데이터가 없을 경우 메시지 표시
                : ListView.builder(
              itemCount: wordList.length,
              itemBuilder: (context, index) {
                return _buildWordCard(wordList[index]); // 단어 카드 빌드
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                // 학습 시작 버튼 클릭 시 학습 화면으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChapterScreen1(chapterId: widget.chapter.chapterId), // 올바른 chapterId 전달
                  ),
                );
              },
              child: Text(
                "학습 시작",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
