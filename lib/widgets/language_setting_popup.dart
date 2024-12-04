import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore 임포트
import '../data/database.dart';
import '../data/user_model.dart';
import '../data/user_table.dart';
import '../services/translation_service.dart';
import 'package:lanny_program/FireStore/AuthService.dart';

Future<void> showLanguageSettingPopup(BuildContext context, String userId) async {
  String? selectedLanguage; // 선택된 언어를 저장하는 변수

  selectedLanguage = await showDialog<String?>(
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
  );

  if (selectedLanguage != null) {
    print("선택된 언어: $selectedLanguage");

    // 선택된 언어를 데이터베이스에 저장
    await _saveLanguageToDatabase(userId, selectedLanguage!);

    // Firestore의 learningLanguage 필드도 업데이트
    await _updateLearningLanguage(userId, selectedLanguage!);

    // 메인 화면으로 이동
    Navigator.pushReplacementNamed(context, '/main');
  }
}

// 선택된 언어를 Firestore의 learningLanguage에 저장하는 함수
Future<void> _updateLearningLanguage(String userId, String language) async {
  try {
    final userDoc = FirebaseFirestore.instance.collection('user').doc(userId);
    await userDoc.update({'learningLanguage': language});
    print("Firestore: learningLanguage updated to $language for user: $userId");
  } catch (e) {
    print("Error updating learningLanguage: $e");
  }
}

// 선택된 언어를 데이터베이스에 저장하는 함수
Future<void> _saveLanguageToDatabase(String userId, String language) async {
  UserTable userTable = UserTable();
  AuthService authService = AuthService();

  try {
    // Firestore에 업데이트
    await authService.updateFieldByID(userId, 'selectedLanguage', language);
    print("Firestore: selectedLanguage updated for user: $userId");

    // SQLite 업데이트
    await userTable.updateUserLanguage(userId, language);
    print("SQLite: selectedLanguage updated for user: $userId");

  } catch (e) {
    print("Error updating selectedLanguage: $e");
  }
}
