import 'package:flutter/material.dart';
import 'learning_screen3.dart'; // LearnScreen3 페이지를 import합니다.
import '../widgets/stop_popup.dart';
import 'package:lanny_program/widgets/correct_answer_popup.dart'; // CorrectAnswerPopup 파일을 import합니다.

class LearnScreen2 extends StatefulWidget {
  final List<Map<String, String>> chapterWords; // chapterWords를 생성자에서 받아옴

  // 생성자에서 chapterWords를 받아서 초기화
  LearnScreen2({required this.chapterWords});

  @override
  _LearnScreen2State createState() => _LearnScreen2State();
}

class _LearnScreen2State extends State<LearnScreen2> {
  // 각 이미지의 색상 상태를 관리하기 위한 변수
  Color _sunColor = Colors.transparent;
  Color _breadColor = Colors.transparent;
  Color _tshirtColor = Colors.transparent;
  Color _socksColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    // 첫 번째 단어를 가져오기
    final currentWord = widget.chapterWords[1]; // 예시로 두 번째 단어 사용 (사과)

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
                            value: 2 / 15, // 페이지 진행 상태 업데이트
                            backgroundColor: Colors.grey,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '2/15',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward, color: Colors.grey),
                          onPressed: () {
                            // LearnScreen3 페이지로 이동
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LearnScreen3(chapterWords: widget.chapterWords),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _sunColor = _sunColor == Colors.transparent
                          ? Colors.green.withOpacity(0.5)
                          : Colors.transparent;
                    });
                  },
                  child: Container(
                    color: _sunColor,
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(
                      widget.chapterWords[1]['image']!, // 현재 단어의 이미지로 설정
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                SizedBox(width: 100),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _breadColor = _breadColor == Colors.transparent
                          ? Colors.green.withOpacity(0.5)
                          : Colors.transparent;
                    });
                  },
                  child: Container(
                    color: _breadColor,
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/bread.png', // 고정된 이미지로 유지
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _tshirtColor = _tshirtColor == Colors.transparent
                          ? Colors.green.withOpacity(0.5)
                          : Colors.transparent;
                    });
                  },
                  child: Container(
                    color: _tshirtColor,
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/tshirt.png', // 고정된 이미지로 유지
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                SizedBox(width: 100),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _socksColor = _socksColor == Colors.transparent
                          ? Colors.green.withOpacity(0.5)
                          : Colors.transparent;
                    });
                  },
                  child: Container(
                    color: _socksColor,
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/socks.png', // 고정된 이미지로 유지
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 200, // 버튼 너비를 줄임
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CorrectAnswerPopup(),
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
