import 'package:flutter/material.dart';

class CorrectAnswerPopup extends StatelessWidget {
  final String wordImgPath; // 이미지 경로
  final String koreanWord; // 원본 텍스트
  final String translatedWord; // 번역 텍스트

  // 데이터를 생성자에서 받아옵니다.
  CorrectAnswerPopup({
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
      backgroundColor: Color(0xFFF1F3E8),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        width: 398,
        height: 231,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '정답입니다!',
              style: TextStyle(
                color: Color(0xFF4FA55B),
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
                  backgroundColor: Color(0xFF4FA55B),
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
