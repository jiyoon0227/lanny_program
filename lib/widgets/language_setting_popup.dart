import 'package:flutter/material.dart';

import '../data/database.dart';
import '../data/user_table.dart';
import '../services/translation_service.dart';

void showLanguageSettingPopup(BuildContext context) {
  String? selectedLanguage; // 선택된 언어를 저장하는 변수

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder( // StatefulBuilder를 사용해 상태 관리
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: EdgeInsets.all(16),
            content: SingleChildScrollView( // 스크롤 가능하게 만듦
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '학습 언어 설정',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    '나의 언어',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/korea.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    title: Text('한국어'),
                    onTap: () {
                      setState(() {
                        selectedLanguage = '한국어';
                      });
                    },
                    selected: selectedLanguage == '한국어', // 선택된 항목 표시
                    selectedTileColor: Colors.grey[200], // 선택 시 배경색 변경
                  ),
                  SizedBox(height: 10),
                  Text(
                    '모든 언어',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/USA.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    title: Text('영어'),
                    onTap: () {
                      setState(() {
                        selectedLanguage = '영어';
                      });
                    },
                    selected: selectedLanguage == '영어',
                    selectedTileColor: Colors.grey[200],
                  ),
                  ListTile(
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/china.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    title: Text('중국어'),
                    onTap: () {
                      setState(() {
                        selectedLanguage = '중국어';
                      });
                    },
                    selected: selectedLanguage == '중국어',
                    selectedTileColor: Colors.grey[200],
                  ),
                  ListTile(
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/france.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    title: Text('프랑스어'),
                    onTap: () {
                      setState(() {
                        selectedLanguage = '프랑스어';
                      });
                    },
                    selected: selectedLanguage == '프랑스어',
                    selectedTileColor: Colors.grey[200],
                  ),
                  ListTile(
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/germany.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    title: Text('독일어'),
                    onTap: () {
                      setState(() {
                        selectedLanguage = '독일어';
                      });
                    },
                    selected: selectedLanguage == '독일어',
                    selectedTileColor: Colors.grey[200],
                  ),
                  ListTile(
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/japan.png'), // 일본 국기 이미지 추가
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    title: Text('일본어'),
                    onTap: () {
                      setState(() {
                        selectedLanguage = '일본어';
                      });
                    },
                    selected: selectedLanguage == '일본어',
                    selectedTileColor: Colors.grey[200],
                  ),
                  // 스페인어 추가
                  ListTile(
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/spain.png'), // 스페인 국기 이미지 추가
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    title: Text('스페인어'),
                    onTap: () {
                      setState(() {
                        selectedLanguage = '스페인어';
                      });
                    },
                    selected: selectedLanguage == '스페인어',
                    selectedTileColor: Colors.grey[200],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(selectedLanguage); // 선택된 언어를 반환
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4FA55B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('확인'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  ).then((selectedLanguage) {
    if (selectedLanguage != null) {
      // 선택된 언어를 사용
      print("선택된 언어: $selectedLanguage");

      // 선택된 언어를 데이터베이스에 저장
      _saveLanguageToDatabase(selectedLanguage);
      // 선택된 언어를 기준으로 번역 작업 실행
      _translateWordsForSelectedLanguage(selectedLanguage);
      // 팝업이 닫힌 후 홈 화면으로 이동
      Navigator.pushReplacementNamed(context, '/main'); // 홈 화면으로 이동
    }
  });
}
// 선택된 언어를 데이터베이스에 저장하는 함수
void _saveLanguageToDatabase(String language) async {
  UserTable userTable = UserTable();
  // 현재 userId 없이 단일 사용자로 처리
  await userTable.updateUserLanguage("default_user", language);
}

// 선택된 언어로 번역 작업을 수행하는 함수
void _translateWordsForSelectedLanguage(String language) async {
  TranslationService translationService = TranslationService();
  // 여기서는 예시로 모든 챕터에 대해 번역을 수행한다고 가정
  List<int> chapterIds = [1, 2, 3, 4, 5 ,6 ,7]; // 각 챕터의 ID 목록
  await translationService.translateAndUpdateWordsByChapter(chapterIds, language);
}