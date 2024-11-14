import 'package:flutter/material.dart';
import 'learning_screen4.dart'; // LearnScreen4 페이지가 있는 파일을 import하세요.
import '../widgets/stop_popup.dart';
import 'package:lanny_program/widgets/fail_answer_popup.dart'; // FailAnswerPopup 파일을 import하세요.

class LearnScreen3 extends StatefulWidget {
  // chapterWords를 생성자에서 받도록 변경
  final List<Map<String, String>> chapterWords;

  // 생성자에서 chapterWords를 받는 방식
  LearnScreen3({required this.chapterWords});

  @override
  _LearnScreen3State createState() => _LearnScreen3State();
}

class _LearnScreen3State extends State<LearnScreen3> {
  // 각 텍스트의 색상 상태를 관리하기 위한 변수
  Color _topTextBackgroundColor = Colors.transparent;
  Color _bottomTextBackgroundColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    // 첫 번째 단어를 가져오기
    final currentWord = widget.chapterWords[0]; // 생성자에서 받은 chapterWords 사용

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DefaultTextStyle(
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 3 / 15, // 페이지 진행 상태 업데이트
                            backgroundColor: Colors.grey,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '3/15',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward, color: Colors.grey),
                          onPressed: () {
                            // LearnScreen4 페이지로 이동
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LearnScreen4(chapterWords: widget.chapterWords),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
                Positioned(
                  left: 0,
                  top: 16,
                  child: Material(
                    type: MaterialType.transparency,
                    child: IconButton(
                      icon: Icon(Icons.pause, color: Colors.grey),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => PausePopup(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
            // Top text
            GestureDetector(
              onTap: () {
                setState(() {
                  _topTextBackgroundColor = _topTextBackgroundColor == Colors.transparent
                      ? Colors.green.withOpacity(0.5)
                      : Colors.transparent;
                });
              },
              child: Center(
                child: Container(
                  color: _topTextBackgroundColor,
                  child: Column(
                    children: [
                      Text(
                        currentWord['word_jp']!, // 현재 단어의 일본어 텍스트
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '(${currentWord['pronunciation']})', // 발음 표시
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            // Center image (T-shirt)
            Center(
              child: Image.asset(
                currentWord['image']!, // 현재 단어에 맞는 이미지
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 50),
            // Bottom text
            GestureDetector(
              onTap: () {
                setState(() {
                  _bottomTextBackgroundColor = _bottomTextBackgroundColor == Colors.transparent
                      ? Colors.green.withOpacity(0.5)
                      : Colors.transparent;
                });
              },
              child: Center(
                child: Container(
                  color: _bottomTextBackgroundColor,
                  child: Column(
                    children: [
                      Text(
                        widget.chapterWords[1]['word_jp']!, // 두 번째 단어의 일본어 텍스트 (양말)
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '(${widget.chapterWords[1]['pronunciation']})', // 발음 표시
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 100),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 200, // 버튼 너비를 줄임
                child: ElevatedButton(
                  onPressed: () {
                    // 답안 제출 시 FailAnswerPopup을 호출
                    showDialog(
                      context: context,
                      builder: (context) => FailAnswerPopup(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    backgroundColor: Colors.green, // 버튼 배경색 설정
                  ),
                  child: Text(
                    '답안 제출',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
