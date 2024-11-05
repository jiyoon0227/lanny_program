import 'package:flutter/material.dart';

class learn_screen3 extends StatefulWidget {
  @override
  _LearnScreen3State createState() => _LearnScreen3State();
}

class _LearnScreen3State extends State<learn_screen3> {
  // 각 텍스트의 색상 상태를 관리하기 위한 변수
  Color _topTextBackgroundColor = Colors.transparent;
  Color _bottomTextBackgroundColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 6, // 60% 너비로 설정
                    child: LinearProgressIndicator(
                      value: 1 / 15,
                      backgroundColor: Colors.grey,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    flex: 4, // 남은 40%는 텍스트가 차지
                    child: Text(
                      '1/15',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
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
                    _topTextBackgroundColor = _topTextBackgroundColor == Colors.transparent
                        ? Colors.green.withOpacity(0.5)
                        : Colors.transparent;
                  });
                },
                child: Align(
                  alignment: Alignment(-0.5, 0), // 적당한 위치로 조정
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
              Align(
                alignment: Alignment(-0.5, 0), // 적당한 위치로 조정
                child: Container(
                  child: Image.asset(
                    'assets/images/tshirt.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              SizedBox(height: 50), // 티셔츠와 텍스트 사이의 간격 조정
              // Bottom text
              GestureDetector(
                onTap: () {
                  setState(() {
                    _bottomTextBackgroundColor = _bottomTextBackgroundColor == Colors.transparent
                        ? Colors.green.withOpacity(0.5)
                        : Colors.transparent;
                  });
                },
                child: Align(
                  alignment: Alignment(-0.5, 0), // 적당한 위치로 조정
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
          // Pause button
          Positioned(
            left: 0,
            top: 16,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(Icons.pause, color: Colors.grey),
                onPressed: () {
                  // Pause action
                  print('Pause button pressed');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}