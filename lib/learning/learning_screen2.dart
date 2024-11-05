import 'package:flutter/material.dart';

class learn_screen2 extends StatefulWidget {
  @override
  _LearnScreen2State createState() => _LearnScreen2State();
}

class _LearnScreen2State extends State<learn_screen2> {
  // 각 이미지의 색상 상태를 관리하기 위한 변수
  Color _sunColor = Colors.transparent;
  Color _breadColor = Colors.transparent;
  Color _tshirtColor = Colors.transparent;
  Color _socksColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress bar and actions
          Stack(
            clipBehavior: Clip.none,
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
                  SizedBox(width: 8),
                  Text(
                    '1/15',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                ],
              ),
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
          SizedBox(height: 100), // 사진 위 간격 조정
          // Top images
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // 왼쪽 정렬
            children: [
              SizedBox(width: 60), // 왼쪽 간격 추가
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
                    'assets/images/sun.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              SizedBox(width: 100), // 사진 간 간격 조정
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
                    'assets/images/bread.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 100), // 텍스트와 사진 사이의 간격 조정
          // Center text
          Align(
            alignment: Alignment(-0.65, 0.2), // 텍스트를 화면의 1/4 위치로 정렬
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
          SizedBox(height: 100), // 텍스트와 사진 사이의 간격 조정
          // Bottom images
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // 왼쪽 정렬
            children: [
              SizedBox(width: 60), // 왼쪽 간격 추가
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
                    'assets/images/tshirt.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              SizedBox(width: 100), // 사진 간 간격 조정
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
                    'assets/images/socks.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 100), // 사진 아래 간격 추가
        ],
      ),
    );
  }
}