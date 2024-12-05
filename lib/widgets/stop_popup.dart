import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../data/chapter_table.dart'; // ChapterTable 추가

class PausePopup extends StatelessWidget {
  final int chapterId; // 챕터 ID 추가
  final int progressCount; // 진행도 추가

  PausePopup({required this.chapterId, required this.progressCount});

  Future<void> _saveProgress(BuildContext context) async {
    try {
      double progress = progressCount / 15.0; // 0.0 ~ 1.0 값으로 변환
      final chapterTable = ChapterTable();
      await chapterTable.updateChapterProgress(chapterId, progress);
      print("저장되는 진행도: $progress, chapterId: $chapterId");
    } catch (e) {
      print("진행도 저장 중 오류 발생: $e");
    } finally {
      Navigator.pushReplacementNamed(context, '/main'); // 홈 화면으로 이동
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFF1F3E8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      contentPadding: EdgeInsets.all(0),
      content: Container(
        width: 323,
        height: 175,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.grey),
                onPressed: () {
                  // 팝업창 닫기
                  Navigator.of(context).pop();
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Text(
                  '일시정지',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Icon(
                  Icons.pause,
                  color: Colors.grey,
                  size: 30,
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFD8E3C0),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            iconSize: 30,
                            icon: Icon(Icons.stop, color: Colors.grey),
                            onPressed: () => _saveProgress(context),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text('중지'),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            iconSize: 30,
                            icon: Icon(Icons.play_arrow, color: Colors.white),
                            onPressed: () {
                              // 이어하기 기능
                              Navigator.of(context).pop(); // 팝업 닫기
                            },
                          ),
                        ),
                        SizedBox(height: 4),
                        Text('이어하기'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
