import 'package:flutter/material.dart';
import '../widgets/stop_popup.dart';

class LearnScreen2 extends StatefulWidget {
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
                        SizedBox(width: 8),
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
                  top: 16, // 위치 조정
                  child: Material(
                    type: MaterialType.transparency,
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
            // Top images
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
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
            Center(
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
              mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
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
      ),
    );
  }
}