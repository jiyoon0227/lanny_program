import 'package:flutter/material.dart';
import '../widgets/daily_learning_goal_popup.dart'; // 추가

class welcome_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // -----일일 학습 목표량 임시 확인 ------
    /*
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dailyLearningGoalPopup(context);
    });
    */
    //-----------
    return Scaffold(
      body: Stack(
        children: [
          // 핑크 아이콘: 알파벳 e 위쪽에 위치
          Positioned(
            left: 120,
            top: 270,
            child: Image.asset(
              'assets/images/Icon1.png', // 핑크 아이콘 파일 경로
              width: 50, // 크기 조정
              height: 50,
            ),
          ),
          // 연두색 아이콘: "언어 학습앱" 글자 옆에 위치
          Positioned(
            left: 280,
            top: 430,
            child: Image.asset(
              'assets/images/Icon2.png', // 연두색 아이콘 파일 경로
              width: 150, // 크기 조정
              height: 150,
            ),
          ),
          // 텍스트와 버튼
          Positioned(
            left: 39,
            top: 298,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'L',
                        style: TextStyle(
                          color: Color(0xFF4FA55B),
                          fontSize: 48,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: 'a',
                        style: TextStyle(
                          color: Color(0xFF4FA55B),
                          fontSize: 64,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'nguage',
                        style: TextStyle(
                          color: Color(0xFFB2B99E),
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 7),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'bu',
                        style: TextStyle(
                          color: Color(0xFFB2B99E),
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: 'nny',
                        style: TextStyle(
                          color: Color(0xFF4FA55B),
                          fontSize: 48,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 42),
                Text(
                  '래니: 매일 생각나는 언어 학습앱',
                  style: TextStyle(
                    color: Color(0xFF676C5A),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.15,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 33,
            top: 688,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4FA55B),
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    '시작하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    '이미 계정이 있으신가요? 로그인',
                    style: TextStyle(
                      color: Color(0xFF4FA55B),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
