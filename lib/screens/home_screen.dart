import 'package:flutter/material.dart';
import 'package:lanny_program/widgets/daily_learning_goal_popup.dart'; // 팝업 파일을 임포트
import '../data/chapter_table.dart';
import '../data/chapter_model.dart';
import 'package:lanny_program/learning/chapter_screen1.dart'; // 챕터 화면들 임포트
import 'package:lanny_program/learning/chapter_screen2.dart';
import 'package:lanny_program/learning/chapter_screen3.dart';
import 'package:lanny_program/learning/chapter_screen4.dart';
import 'package:lanny_program/learning/chapter_screen5.dart';
import 'package:lanny_program/learning/chapter_screen6.dart';
import 'package:lanny_program/learning/chapter_screen7.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ChapterTable chapterTable = ChapterTable();
  List<ChapterModel> chapters = [];

  @override
  void initState() {
    super.initState();
    _loadChapters();
  }

  // 데이터베이스에서 챕터 데이터 가져오기
  Future<void> _loadChapters() async {
    List<Map<String, dynamic>> chapterData = await chapterTable.getAllChapters();
    setState(() {
      chapters = chapterData.map((data) => ChapterModel.fromMap(data)).toList();
    });
  }

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
        child: chapters.isEmpty
            ? Center(child: CircularProgressIndicator()) // 데이터 로딩 중일 때 로딩 표시
            : ListView.builder(
          itemCount: chapters.length,
          itemBuilder: (context, index) {
            final chapter = chapters[index];
            double progressValue = chapter.progress; // 진행도 수치 (0 ~ 1)
            double progressWidth = (15 * progressValue) * 220; // 진행도에 따른 길이

            return _buildChapterSection(context, index, chapter, progressWidth);
          },
        ),
      ),
    );
  }

  Widget _buildChapterSection(BuildContext context, int index, ChapterModel chapter, double progressWidth) {
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
              "챕터 ${index + 1} - ${chapter.chapterName}",
              chapter.chapterDescription,
              chapter.progress,
              progressWidth,
            ),
          ),
        ),
        const SizedBox(width: 25),
      ],
    );
  }

  Widget _buildChapterTile(String title, String description, double progressValue, double progressWidth) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFFB3BA9F), // 텍스트 색상 설정
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: Color(0xFFB3BA9F), // 텍스트 색상 설정
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 8,
                width: progressWidth,
                decoration: BoxDecoration(
                  color: Color(0xFFB3BA9F), // 게이지 색상 설정
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.arrow_forward, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
