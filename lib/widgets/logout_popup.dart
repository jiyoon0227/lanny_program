import 'package:flutter/material.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true, // 바깥 영역을 터치해도 팝업이 닫히지 않음
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          width: 323,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFFF1F3E8),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 팝업 상단 타이틀과 닫기 아이콘
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '로그아웃',
                    style: TextStyle(
                      color: Color(0xFF676C5A),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Color(0xFF676C5A)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                '로그아웃 할까요?',
                style: TextStyle(
                  color: Color(0xFF676C5A),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '계정에 기록된 학습 데이터는 보존되며,\n로그아웃 시 메인화면으로 이동합니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFB2B99E),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              // 취소 및 확인 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      side: BorderSide(color: Color(0xFFB2B99E)),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text(
                      '취소',
                      style: TextStyle(
                        color: Color(0xFFB2B99E),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 팝업 닫기
                      Navigator.pushReplacementNamed(context, '/login'); // 로그인 화면으로 이동
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF4FA55B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text(
                      '확인',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
