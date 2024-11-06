import 'package:flutter/material.dart';
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
          color: Colors.black, // 기본 텍스트 색상
          fontSize: 16, // 기본 폰트 크기
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
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 1 / 15,
                            backgroundColor: Colors.grey,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width: 8), // 여백 추가
                        Text(
                          '1/15',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
                Positioned(
                  left: 0,
                  top: 16, // 이 값을 조정하여 원하는 위치에 배치
                  child: Material(
                    type: MaterialType.transparency, // 버튼이 눌리도록 투명한 Material 사용
                    child: IconButton(
                      icon: Icon(Icons.pause, color: Colors.grey),
                      onPressed: () {
                        // PausePopup 표시
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
            SizedBox(height: 100), // 사진 위 간격 조정
            // Top text
            GestureDetector(
              onTap: () {
                setState(() {
                  _topTextBackgroundColor =
                  _topTextBackgroundColor == Colors.transparent
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
            SizedBox(height: 50), // 텍스트와 티셔츠 사이의 간격 조정
            // Center image (T-shirt)
            Center(
              child: Image.asset(
                'assets/images/tshirt.png',
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 50), // 티셔츠와 텍스트 사이의 간격 조정
            // Bottom text
            GestureDetector(
              onTap: () {
                setState(() {
                  _bottomTextBackgroundColor =
                  _bottomTextBackgroundColor == Colors.transparent
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
            SizedBox(height: 100), // 텍스트 아래 간격 추가
          ],
        ),
      ),
    );
  }
}