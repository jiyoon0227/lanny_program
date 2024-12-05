import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Import Cupertino for CupertinoColors
import 'package:lanny_program/widgets/daily_learning_goal_popup.dart'; // Import the popup
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/language_setting_popup.dart';

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final List<Map<String, dynamic>> items = [
    {'chapter': '챕터1', 'japanese': 'パン', 'korean': '빵', 'progress': 3},
    {'chapter': '챕터2', 'japanese': 'ズボン', 'korean': '바지', 'progress': 7},
  ]; // 확인용 예시

  String searchQuery = '';
  String selectedLanguage = "";
  String continuous = "0";
  int dailyGoal = 15;
  int currentProgress = 0;

  @override
  void initState() {
    super.initState();
    _loadUserLanguage();
    _listenToUserProgress();
  }

  Future<void> _loadUserLanguage() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            selectedLanguage = userDoc['selectedLanguage'] ?? "언어 미지정";
          });
        }
      }
    } catch (e) {
      print("Error loading user language: $e");
    }
  }

  void _listenToUserProgress() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('user')
          .doc(currentUser.uid)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          setState(() {
            dailyGoal = snapshot.data()?['dailyGoal'] ?? 15;
            currentProgress = snapshot.data()?['currentProgress'] ?? 0;
            continuous = snapshot.data()?['continuous'] ?? "0";
          });
        }
      });
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
                    'assets/images/home_timer.png',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () async {
                    int? updatedDailyGoal = await dailyLearningGoalPopup(context);
                    if (updatedDailyGoal != null) {
                      User? currentUser = FirebaseAuth.instance.currentUser;
                      if (currentUser != null) {
                        await FirebaseFirestore.instance
                            .collection('user')
                            .doc(currentUser.uid)
                            .update({'dailyGoal': updatedDailyGoal});
                      }
                    }
                  },
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () async {
                    await dailyLearningGoalPopup(context);
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(),
                    SizedBox(height: 16),
                    _buildSearchResults(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: Column(
              children: [
                Icon(Icons.pets, color: Color(0xFFB2B99E), size: 40),
                SizedBox(height: 8),
                Text(
                  'Advanced Mobile Programming(8)\nCopyright 2024. 조아영, 김지윤, 양희수, 윤자원 All rights reserved.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CupertinoColors.inactiveGray,
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xFFF1F3E8),
        borderRadius: BorderRadius.circular(48),
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 16, color: Colors.black),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: '배웠던 단어를 조회할 수 있어요',
                border: InputBorder.none,
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query.trim();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchQuery.isEmpty) {
      return Container(); // Empty container when no search query
    }

    final filteredItems = items.where((item) {
      final korean = item['korean'] ?? '';
      return korean.contains(searchQuery);
    }).toList();

    if (filteredItems.isEmpty) {
      return Center(child: Text('검색 결과가 없습니다.'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            '검색결과: ${filteredItems.length}건',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFFB3BA9F)),
          ),
        ),
        Divider(color: Colors.grey.shade300, thickness: 0.5),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredItems.length,
          separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300, thickness: 0.5),
          itemBuilder: (context, index) {
            final item = filteredItems[index];
            return _buildChapterSection(item);
          },
        ),
      ],
    );
  }

  Widget _buildChapterSection(Map<String, dynamic> item) {
    final progress = item['progress'] ?? 0;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 69,
            height: 61,
            color: Colors.grey,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['chapter'] ?? '',
                  style: TextStyle(
                    backgroundColor: Color(0xFFEAEED1),
                    fontSize: 8,
                  ),
                ),
                Text(
                  item['japanese'] ?? '',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF232323),
                  ),
                ),
                Text(
                  item['korean'] ?? '',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
                SizedBox(height: 4),
                LinearProgressIndicator(
                  value: progress / 15,
                  backgroundColor: Color(0xFFEAEED1),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4FA55B)),
                ),
                Text('$progress / 15', style: TextStyle(fontSize: 12, color: Color(0xFFBDBDBD))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
