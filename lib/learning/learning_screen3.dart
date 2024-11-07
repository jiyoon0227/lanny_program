import 'package:flutter/material.dart';
import 'learning_screen4.dart'; // LearnScreen4 페이지가 있는 파일을 import하세요.
import '../widgets/stop_popup.dart';

class LearnScreen3 extends StatefulWidget {
  @override
  _LearnScreen3State createState() => _LearnScreen3State();
}

class _LearnScreen3State extends State<LearnScreen3> {
  // 각 텍스트의 색상 상태를 관리하기 위한 변수
  Color _topTextBackgroundColor = Colors.transparent;
  Color _bottomTextBackgroundColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
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
                                builder: (context) => LearnScreen4(),
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
                        'はんそで',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '(hansode)',
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
                'assets/images/tshirt.png',
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
                        'くつした',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '(kutsushita)',
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
          ],
        ),
      ),
    );
  }
}
