import 'package:flutter/material.dart';
import '../data/chapter_model.dart';
import '../data/chapter_table.dart';
import 'package:lanny_program/data/word_table.dart';
import 'package:lanny_program/learning/chapter_screen1.dart';
import 'package:lanny_program/learning/chapter_screen2.dart';
import 'package:lanny_program/learning/chapter_screen3.dart';
import 'package:lanny_program/learning/chapter_screen4.dart';
import 'package:lanny_program/learning/chapter_screen5.dart';
import 'package:lanny_program/learning/chapter_screen6.dart';
import 'package:lanny_program/learning/chapter_screen7.dart';

class ChapterCoverPage extends StatefulWidget {
  final int chapterIndex;
  final ChapterModel chapter;

  ChapterCoverPage({required this.chapterIndex, required this.chapter});

  @override
  _ChapterCoverPageState createState() => _ChapterCoverPageState();
}

class _ChapterCoverPageState extends State<ChapterCoverPage> {
  List<Map<String, String>> wordList = [];
  final ChapterTable chapterTable = ChapterTable();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  // 단어 데이터를 로드하는 함수 (최대 5개)
  Future<void> _loadWords() async {
    List<Map<String, String>> words = await chapterTable.getWordsForChapter(widget.chapter.chapterId);
    setState(() {
      wordList = words.take(5).toList(); // 최대 5개 단어만 가져오기
      isLoading = false;
    });
  }

  // 각 챕터에 맞는 학습 화면 반환
  Widget _getChapterScreen() {
    switch (widget.chapterIndex) {
      case 0:
        return ChapterScreen1();
      case 1:
        return ChapterScreen2();
      case 2:
        return ChapterScreen3();
      case 3:
        return ChapterScreen4();
      case 4:
        return ChapterScreen5();
      case 5:
        return ChapterScreen6();
      case 6:
        return ChapterScreen7();
      default:
        return ChapterScreen1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapter.chapterName),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
                  widget.chapter.chapterName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(widget.chapter.chapterDescription),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator()) // 로딩 중 표시
                : wordList.isEmpty
                ? Center(child: Text("단어 데이터가 없습니다.")) // 데이터가 없을 경우
                : ListView.builder(
              itemCount: wordList.length,
              itemBuilder: (context, index) {
                final word = wordList[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: word['image'] != null
                        ? Image.asset(word['image']!, width: 40, height: 40, fit: BoxFit.cover)
                        : Icon(Icons.image, size: 40),
                    title: Text(
                      word['word'] ?? '',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      word['translation'] ?? '',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _getChapterScreen()),
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
