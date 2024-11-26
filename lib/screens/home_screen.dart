import 'package:flutter/material.dart';
import 'package:lanny_program/widgets/daily_learning_goal_popup.dart'; // 팝업 파일을 임포트
import '../data/chapter_table.dart';
import '../data/chapter_model.dart';
import '../data/user_table.dart';
import '../data/user_model.dart';
import 'chapter_cover.dart'; // chapter_cover.dart 임포트
//*****
import '../data/word_table.dart'; // 단어 테이블 임포트
//*****
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ChapterTable chapterTable = ChapterTable();
  //*****
  final WordTable wordTable = WordTable(); // WordTable 인스턴스 추가
  //*****
  List<ChapterModel> chapters = [];

  String selectedLanguage = "한국어"; // 기본값으로 설정

  @override
  void initState() {
    super.initState();
    _loadUserLanguage(); // 사용자 언어 설정 불러오기
    _loadChapters();
    //*****
    _printWordTableContents(); // 단어 테이블 내용을 프린트로 확인하기 위한 함수 호출
  }
  //*****
  void _printWordTableContents() async {
    // 단어 테이블의 모든 데이터를 가져와 콘솔에 출력하는 함수
    List<Map<String, dynamic>> wordData = await wordTable.getAllWords();
    for (var word in wordData) {
      print('Word: ${word['korean_word']}, Translated: ${word['translated_word']}, Romanized: ${word['romanized_word']}');
    }
  }
  //*****
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 화면이 표시될 때마다 언어 설정 확인
    _loadUserLanguage();
  }

  void _loadUserLanguage() async {
    UserTable userTable = UserTable();
    Map<String, dynamic>? userMap = await userTable.getUser("default_user");

    if (userMap != null) {
      UserModel user = UserModel.fromMap(userMap);
      if (user.userSelectedLanguage != null) {
        setState(() {
          selectedLanguage = user.userSelectedLanguage!; // 사용자 언어 정보 반영
        });
      }
    }
  }

  // 데이터베이스에서 챕터 데이터 가져오기
  Future<void> _loadChapters() async {
    List<Map<String, dynamic>> chapterData = await chapterTable.getAllChapters();
    setState(() {
      chapters = chapterData.map((data) => ChapterModel.fromMap(data)).toList();
    });
  }
  String _getLanguageIconPath(String language) {
    switch (language) {
      case '영어':
        return 'assets/images/lang_english_circle.png';
      case '중국어':
        return 'assets/images/lang_chinese_circle.png';
      case '프랑스어':
        return 'assets/images/lang_french_circle.png';
      case '독일어':
        return 'assets/images/lang_germany_circle.png';
      case '일본어':
        return 'assets/images/lang_japanese_circle.png';
      case '스페인어':
        return 'assets/images/lang_spain_circle.png';
      default:
        return 'assets/images/lang_english_circle.png';
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
                      image: AssetImage(_getLanguageIconPath(selectedLanguage)), // 선택된 언어에 따른 이미지 경로
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
              // 각 챕터 클릭 시 chapter_cover.dart로 데이터 전달
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChapterCoverPage(
                    chapterIndex: index,
                    chapter: chapter,
                  ),
                ),
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
