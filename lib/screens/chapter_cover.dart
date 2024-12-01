import 'package:flutter/material.dart';
import '../data/chapter_model.dart';
import '../data/chapter_table.dart';
import 'package:lanny_program/learning/chapter_screen1.dart';

class ChapterCoverPage extends StatefulWidget {
  final int chapterIndex;
  final ChapterModel chapter;

  ChapterCoverPage({required this.chapterIndex, required this.chapter});

  @override
  _ChapterCoverPageState createState() => _ChapterCoverPageState();
}

class _ChapterCoverPageState extends State<ChapterCoverPage> {
  final ChapterTable chapterTable = ChapterTable(); // ChapterTable 인스턴스 생성
  List<Map<String, String>> wordList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  // 단어 데이터를 메모리에서 가져오기
  Future<void> _loadWords() async {
    try {
      final words = await chapterTable.getWordsForChapter(widget.chapter.chapterId);
      setState(() {
        wordList = words.take(5).toList(); // 상위 5개 단어 가져오기
        isLoading = false;
      });
    } catch (e) {
      print('단어 데이터를 불러오는 중 오류 발생: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // 각 챕터에 맞는 학습 화면 반환
  Widget _getChapterScreen() {
        return ChapterScreen1(chapterId: widget.chapter.chapterId); // chapterId 전달
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapter.chapterName),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
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
                ? Center(child: CircularProgressIndicator()) // 로딩 중
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
                        ? Image.asset(
                      word['image']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                        : Icon(Icons.image, size: 50),
                    title: Text(
                      word['original'] ?? '',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      word['translated'] ?? '',
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
