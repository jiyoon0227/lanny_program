import 'package:flutter/material.dart';

void dailyLearningGoalPopup(BuildContext context) {
  int dailyGoal = 5; // 기본 학습 목표량 (단위: 개)

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Color(0xFFF1F3E8), // 배경색 수정
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center, // 가운데 정렬
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 60),
                  Text(
                    '일일 학습 목표량',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF676C5A),
                    ),
                  ),
                  IconButton(
                    alignment: Alignment.topRight,
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${dailyGoal}',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4FA55B),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '개',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF232323),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Slider(
                value: dailyGoal.toDouble(),
                min: 1,
                max: 10,
                divisions: 4,
                activeColor: Color(0xFF4FA55B), // 슬라이더 활성화 색상 수정
                inactiveColor: Color(0xFFE8E9F1),
                label: '${dailyGoal} 개',
                onChanged: (double value) {
                  dailyGoal = value.toInt();
                  (context as Element).markNeedsBuild();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(dailyGoal); // 선택된 목표량 반환
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4FA55B),
                      minimumSize: Size(180, 48), // 버튼 크기 조정
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      '확인',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  ).then((dailyGoal) {
    if (dailyGoal != null) {
      // 선택된 목표량을 사용
      print("선택된 목표량: ${dailyGoal} 개");
      // 필요한 경우 목표량을 상태에 저장하거나 다른 기능에 전달
    }
  });
}