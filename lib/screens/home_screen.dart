import 'package:flutter/material.dart';
import 'package:lanny_program/widgets/daily_learning_goal_popup.dart'; // 팝업 파일을 임포트
import 'package:lanny_program/learning/learning_screen1.dart'; // learning_screen1 임포트

class HomeScreen extends StatelessWidget {
  final int selectedChapter = 1; // 사용자가 선택한 챕터 인덱스
  final List<String> chapterNames = ['음식', '옷', '날씨', '여행', '문화', '인사', '소속']; // 챕터명 리스트 임시 데이터

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/lang_english_circle.png'), // 사용할 이미지 경로
                      fit: BoxFit.cover, // 이미지를 원형에 맞게 채움
                    ),
                    border: Border.all(
                      color: Colors.grey, // 테두리 색상
                      width: 2, // 테두리 두께
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset(
                  'assets/images/home_fire.png', // 사용할 PNG 파일 경로로 수정
                  width: 30, // 기존 아이콘의 크기와 맞춰 조정
                  height: 30,
                ),
                const SizedBox(width: 8),
                Text(
                  '2',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/images/home_timer.png', // 사용할 PNG 파일 경로로 수정
                    width: 30, // 아이콘과 비슷한 크기
                    height: 30,
                  ),
                  onPressed: () {
                    dailyLearningGoalPopup(context); // 버튼 클릭 시 팝업 창 띄우기
                  },
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    dailyLearningGoalPopup(context); // 버튼 클릭 시 팝업 창 띄우기
                  },
                  child: Text(
                    '0 / 5',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(7, (index) {
                    bool isSelected = index == selectedChapter; // 선택된 챕터 여부 설정
                    bool showGauge = index <= selectedChapter; // 선택된 챕터 및 이전 챕터에만 게이지 표시
                    return _buildChapterSection(context, index, isSelected, showGauge);
                  }),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildContinueTile(),
          ],
        ),
      ),
    );
  }

  Widget _buildChapterSection(BuildContext context, int index, bool isSelected, bool showGauge) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 10),
        Column(
          children: [
            Container(
              width: 2,
              height: 30,
              color: Colors.grey,
            ),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
            ),
            Container(
              width: 2,
              height: 90,
              color: Colors.grey,
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () {
              // 챕터 클릭 시 learning_screen1.dart로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LearnScreen1()),
              );
            },
            child: _buildChapterTile(
              "챕터 ${index + 1} - ${chapterNames[index]}",
              "설명 텍스트를 여기에 추가하세요.",
              isSelected,
              showGauge,
            ),
          ),
        ),
        const SizedBox(width: 25),
      ],
    );
  }

  Widget _buildChapterTile(String title, String description, bool isSelected, bool showGauge) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      width: 300,
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF4FA55B) : Colors.transparent, // 선택된 챕터 여부에 따라 배경색 설정
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xFFB3BA9F), // 선택된 챕터 여부에 따라 텍스트 색상 설정
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xFFB3BA9F), // 선택된 챕터 여부에 따라 텍스트 색상 설정
              fontSize: 14,
            ),
          ),
          if (showGauge) ...[ // 선택된 챕터 및 이전 챕터에만 게이지 바 표시
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(showGauge && !isSelected ? Color(0xFFB3BA9F) : Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.arrow_forward, color: Colors.white),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContinueTile() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '이어서 하기 챕터 2 - 옷',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
