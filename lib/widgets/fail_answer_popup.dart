import 'package:flutter/material.dart';

class FailAnswerPopup extends StatelessWidget {
  final String wordImgPath; // 이미지 경로
  final String koreanWord; // 원본 텍스트
  final String translatedWord; // 번역 텍스트

  // 데이터를 생성자에서 받아옵니다.
  FailAnswerPopup({
    required this.wordImgPath,
    required this.koreanWord,
    required this.translatedWord,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: Color(0xFFFFF1F0), // 배경색을 연한 빨간색 계열로 설정
      child: Container(
        padding: const EdgeInsets.all(24.0),
        width: 398,
        height: 231,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '틀렸습니다!',
              style: TextStyle(
                color: Color(0xFFEF493E), // 빨간색 텍스트
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 전달받은 이미지 경로를 사용합니다.
                Image.asset(
                  wordImgPath,
                  width: 69,
                  height: 61,
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 전달받은 원본 텍스트를 사용합니다.
                    Text(
                      koreanWord,
                      style: TextStyle(
                        color: Color(0xFF232323),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // 전달받은 번역 텍스트를 사용합니다.
                    Text(
                      translatedWord,
                      style: TextStyle(
                        color: Color(0xFFBDBDBD),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 팝업 닫기
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEF493E), // 빨간색 배경
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  '다음 문제',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
