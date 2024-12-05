import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore 임포트
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth 임포트
import 'package:lanny_program/widgets/daily_learning_goal_popup.dart'; // 팝업 파일을 임포트
import '../data/chapter_table.dart';
import '../data/chapter_model.dart';
import '../services/translation_service.dart'; // 번역 서비스 임포트
import '../widgets/language_setting_popup.dart';
import 'chapter_cover.dart'; // chapter_cover.dart 임포트

class HomeScreen extends StatefulWidget {
  final int incrementedValue; // 추가된 필드

  HomeScreen({this.incrementedValue = 0}); // 기본값 설정

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ChapterTable chapterTable = ChapterTable();
  List<ChapterModel> chapters = [];
  String selectedLanguage = ""; // 기본값 제거
  String continuous = "0"; // Firestore에서 로드할 continuous 값
  int highlightedChapterIndex = -1;
  int dailyGoal = 5;
  int currentProgress = 0;

  @override
  void initState() {
    super.initState();
    _loadUserLanguage(); // 사용자 언어 설정 불러오기
    _loadChapters(); // 챕터 정보 불러오기
    _loadContinuousValue(); // continuous 값 로드

    FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        setState(() {
          dailyGoal = snapshot.data()?['dailyGoal'] ?? 5;
          currentProgress = snapshot.data()?['currentProgress'] ?? 0;
        });
      }
    });
  }

  Future<void> _loadContinuousValue() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            continuous = userDoc['continuous'] ?? "0"; // Firestore에서 continuous 값 가져오기
          });
          print("Loaded continuous value: $continuous");
        } else {
          print("User document does not exist in Firestore.");
        }
      } else {
        print("No current user found.");
      }
    } catch (e) {
      print("Error loading continuous value: $e");
    }
  }

  Future<void> _loadUserLanguage() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Firestore에서 사용자 데이터 가져오기
        final userDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            selectedLanguage = userDoc['selectedLanguage'] ?? "언어 미지정";
          });
          print("Loaded user language: $selectedLanguage");
        } else {
          print("User document does not exist in Firestore.");
        }
      } else {
        print("No current user found.");
      }
    } catch (e) {
      print("Error loading user language: $e");
    }
  }

  Future<void> _loadChapters() async {
    try {
      print("Loading chapters...");
      List<Map<String, dynamic>> chapterData = await chapterTable.getAllChapters();
      print("Chapter data loaded: $chapterData");
      int highlightedIndex = -1;
      for (int i = 0; i < chapterData.length; i++) { // [수정 시작] 챕터의 진행도를 검사
        double progress = chapterData[i]['progress'];
        if (progress > 0.0 && progress < 1.0) { // 학습 중인 챕터 (0.0~1.0 사이)
          highlightedIndex = i;
          break;
        }
      }

      if (highlightedIndex == -1) { // 모든 챕터가 완료(1.0) 또는 미학습(0.0)
        for (int i = 0; i < chapterData.length; i++) {
          if (chapterData[i]['progress'] == 0.0) { // 진행도가 0.0인 챕터 중 가장 낮은 번호
            highlightedIndex = i;
            break;
          }
        }
      }
      setState(() {
        chapters = chapterData.map((data) => ChapterModel.fromMap(data)).toList();
        highlightedChapterIndex = highlightedIndex;
      });
    } catch (e) {
      print("Error loading chapters: $e");
    }
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
        GestureDetector(
        onTap: () async {
          User? currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            await showLanguageSettingPopup(context, currentUser.uid);
            await _loadUserLanguage(); // 언어 변경 후 갱신
          }
        },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(_getLanguageIconPath(selectedLanguage)),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
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
            continuous,
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
                  // dailyLearningGoalPopup 호출 이후
                  onPressed: () async {
                    int? updatedDailyGoal = await dailyLearningGoalPopup(context);
                    if (updatedDailyGoal != null) {
                      try {
                        User? currentUser = FirebaseAuth.instance.currentUser;
                        if (currentUser != null) {
                          // Firebase에 dailyGoal 업데이트
                          await FirebaseFirestore.instance
                              .collection('user')
                              .doc(currentUser.uid)
                              .update({'dailyGoal': updatedDailyGoal});
                          print('Firebase에 dailyGoal 업데이트 완료: $updatedDailyGoal');
                        }
                      } catch (e) {
                        print('dailyGoal 업데이트 중 오류 발생: $e');
                      }
                    }
                  },
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () async {
                    String? updatedLanguage = (await dailyLearningGoalPopup(context)) as String?;
                    if (updatedLanguage != null) {
                      print("언어 설정이 변경되었습니다: $updatedLanguage");
                      await _loadUserLanguage(); // 변경된 언어 데이터 다시 로드
                    }
                  },
                  child: Text(
                    '$currentProgress / $dailyGoal',
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
            double progressWidth = (progressValue) * 220; // 진행도에 따른 길이

            return _buildChapterSection(
              context,
              index,
              chapter,
              progressWidth,
              index == highlightedChapterIndex,
            );
          },
        ),
      ),
    );
  }

  Widget _buildChapterSection(BuildContext context, int index, ChapterModel chapter, double progressWidth, bool isHighlighted) {
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
                color: isHighlighted ? Colors.green : Colors.grey,
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
        Expanded(
          child: GestureDetector(
            onTap: () async {
              try {
                final translationService = TranslationService();
                await translationService.translateWordsForSingleChapter(
                  chapter.chapterId,
                  selectedLanguage,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChapterCoverPage(
                      chapterIndex: index,
                      chapter: chapter,
                    ),
                  ),
                );
              } catch (e) {
                print("Error during translation or navigation: $e");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('챕터 이동 중 오류가 발생했습니다. 다시 시도해주세요.'),
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
            child: _buildChapterTile(
              "챕터 ${index + 1} - ${chapter.chapterName}",
              chapter.chapterDescription,
              chapter.progress,
              progressWidth,
              isHighlighted,
            ),
          ),
        ),
        const SizedBox(width: 25),
      ],
    );
  }

  Widget _buildChapterTile(String title, String description, double progressValue, double progressWidth, bool isHighlighted) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isHighlighted ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isHighlighted ? Colors.white : Color(0xFFB3BA9F),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: isHighlighted ? Colors.white : Color(0xFFB3BA9F),
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
                  color: isHighlighted ? Colors.white : Color(0xFFB3BA9F), // 게이지 색상 설정
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
