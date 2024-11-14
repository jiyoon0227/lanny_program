import 'package:flutter/material.dart';
import 'package:lanny_program/widgets/daily_learning_goal_popup.dart'; // 팝업 파일을 임포트
import 'package:lanny_program/learning/chapter_screen1.dart'; // 챕터 화면들 임포트
import 'package:lanny_program/learning/chapter_screen2.dart';
import 'package:lanny_program/learning/chapter_screen3.dart';
import 'package:lanny_program/learning/chapter_screen4.dart';
import 'package:lanny_program/learning/chapter_screen5.dart';
import 'package:lanny_program/learning/chapter_screen6.dart';
import 'package:lanny_program/learning/chapter_screen7.dart';

class HomeScreen extends StatelessWidget {
  final List<String> chapterNames = ['음식', '옷', '날씨', '여행', '문화', '인사', '소속']; // 챕터명 리스트
  final List<int> progressValues = [0, 5, 10, 15, 7, 8, 12]; // 챕터별 진행도 리스트 (0~15)

  // 각 챕터에 해당하는 화면을 반환하는 함수
  Widget _getChapterScreen(int index) {
    switch (index) {
      case 0:
        return ChapterScreen1(); // 음식
      case 1:
        return ChapterScreen2(); // 옷
      case 2:
        return ChapterScreen3(); // 날씨
      case 3:
        return ChapterScreen4(); // 여행
      case 4:
        return ChapterScreen5(); // 문화
      case 5:
        return ChapterScreen6(); // 인사
      case 6:
        return ChapterScreen7(); // 소속
      default:
        return ChapterScreen1(); // 기본 화면 (음식)
    }
  }

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
                      image: AssetImage('assets/images/lang_english_circle.png'),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset(
                  'assets/images/home_fire.png',
                  width: 30,
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
                    'assets/images/home_timer.png',
                    width: 30,
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: ListView(
              padding: EdgeInsets.only(bottom: 100), // 이어서 하기 버튼 공간 확보
              children: [
                ...List.generate(7, (index) {
                  bool isSelected = index == 0; // 첫 번째 챕터가 선택되었다고 가정
                  bool showGauge = index <= 0; // 선택된 챕터 및 이전 챕터에만 게이지 표시
                  return _buildChapterSection(
                    context,
                    index,
                    isSelected,
                    showGauge,
                    progressValues[index],
                  );
                }),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Positioned(
            bottom: 25,
            left: 16,
            right: 16,
            child: _buildContinueTile(), // 이어서 하기 버튼을 항상 하단에 고정
          ),
        ],
      ),
    );
  }

  Widget _buildChapterSection(BuildContext context, int index, bool isSelected, bool showGauge, int progress) {
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
              // 각 챕터 클릭 시 해당 챕터 화면으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _getChapterScreen(index)),
              );
            },
            child: _buildChapterTile(
                "챕터 ${index + 1} - ${chapterNames[index]}",
                "설명 텍스트를 여기에 추가하세요.",
                isSelected,
                showGauge,
                progress,
                index
            ),
          ),
        ),
        const SizedBox(width: 25),
      ],
    );
  }

  Widget _buildChapterTile(String title, String description, bool isSelected, bool showGauge, int progress, int index) {
    double progressValue = (progress / 15).clamp(0.0, 1.0);
    double progressWidth = progress == 0 ? 10 : progressValue * 220;
    double maxProgressWidth = 220;

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF4FA55B) : Colors.transparent,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xFFB3BA9F),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xFFB3BA9F),
              fontSize: 14,
            ),
          ),
          if (showGauge) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 8,
                      width: maxProgressWidth,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F3E8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Container(
                      height: 8,
                      width: progressWidth,
                      decoration: BoxDecoration(
                        color: isSelected ? Color(0xFF232323) : Color(0xFFB3BA9F),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFF4FA55B),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      size: 40,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  '이어하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
