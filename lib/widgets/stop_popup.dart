import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class PausePopup extends StatelessWidget {
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
                SizedBox(height: 10), // 텍스트와 아이콘을 조금 위로 이동
                Text(
                  '일시정지',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5), // 간격 조정
                Icon(
                  Icons.pause,
                  color: Colors.grey,
                  size: 30,
                ),
                SizedBox(height: 5), // 간격 조정
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFD8E3C0), // 베이지빛도는 연두색 배경
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            iconSize: 30,
                            icon: Icon(Icons.stop, color: Colors.grey), // 회색 아이콘
                            onPressed: () {
                              // 중지 기능 - 홈 화면으로 이동
                              Navigator.of(context).pop();  // 팝업 닫기
                              Navigator.pushReplacementNamed(context, '/main'); // 홈 화면으로 이동
                            },
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
                            color: Colors.green, // 초록색 배경
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            iconSize: 30,
                            icon: Icon(Icons.play_arrow, color: Colors.white), // 하얀색 아이콘
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
