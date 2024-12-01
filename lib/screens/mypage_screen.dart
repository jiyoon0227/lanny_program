import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/logout_popup.dart';
import 'package:lanny_program/data/user_model.dart';
import 'package:lanny_program/FireStore/AuthService.dart';



class MyPageScreen extends StatefulWidget {
  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  String userName = '';
  String userEmail = '';
  String learningLanguage = '';
  final AuthService _authService = AuthService();


  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void fetchUserData(String email) async {
    UserData? userData = await _authService.getUserDataByEmail(email);

    if (userData != null) {
      print("User ID: ${userData.id}");
      print("Email: ${userData.email}");
      print("Continuous: ${userData.continuous}");
    } else {
      print("No user found for the given email.");
    }
  }

  Future<void> _loadUserInfo() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            userName = userDoc['name'] ?? '사용자';
            userEmail = userDoc['email'] ?? '이메일 없음';
            learningLanguage = userDoc['language'] ?? '언어 미지정';
          });
        }
      }
    } catch (e) {
      print('Error loading user info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF9F7),
      appBar: AppBar(
        backgroundColor: Color(0xFFFAF9F7),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("마이페이지", style: TextStyle(color: Colors.black)),
            GestureDetector(
              onTap: () {
                showLogoutDialog(context); // 로그아웃 팝업 띄우기
              },
              child: Text("로그아웃", style: TextStyle(color: Color(0xFF71727A), fontSize: 12)),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(24.0),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Color(0xFFD9D9D9),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF232323),
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text('배우고 있는 언어: ', style: TextStyle(color: Color(0xFF232323), fontSize: 12)),
                      Text(learningLanguage, style: TextStyle(color: Color(0xFF4FA55B), fontSize: 12, fontWeight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Icon(Icons.refresh, size: 16, color: Color(0xFF4FA55B)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(userEmail, style: TextStyle(color: Color(0xFF71727A), fontSize: 12)),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
          // 통계 정보 섹션
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem('총 방문 횟수', '6회'),
              _buildStatItem('총 출석', '12일'),
              _buildStatItem('총 학습 시간', '110분'),
            ],
          ),
          SizedBox(height: 40), // 도전 과제 위젯 위에 추가 간격
          // 도전 과제 섹션
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '도전 과제',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF232323),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // 모두보기 로직 추가
                },
                child: Row(
                  children: [
                    Text(
                      '모두보기',
                      style: TextStyle(
                        color: Color(0xFFB2B99E),
                        fontSize: 14,
                      ),
                    ),
                    Icon(Icons.arrow_forward, color: Color(0xFFB2B99E), size: 16),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // 도전 과제 리스트
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFB2B99E)),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildChallengeItem('누적 출석 5일'),
                _buildChallengeItem('연속출석 갱신 3일'),
                _buildChallengeItem('연속출석 갱신 1일'),
                _buildChallengeItem('누적 출석 3일'),
              ],
            ),
          ),
          SizedBox(height: 300),
          // 저작권 정보 위젯 추가
          Center(
            child: Column(
              children: [
                Icon(Icons.pets, color: Color(0xFFB2B99E), size: 40), // 강아지 이미지
                SizedBox(height: 8),
                Text(
                  'Advanced Mobile Programming(8)\nCopyright 2024. 조아영, 김지윤, 양희수, 윤자원 All rights reserved.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:CupertinoColors.inactiveGray,
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
          SizedBox(height: 120), // 하단에 추가 공간을 넣어 더 아래로 내립니다.
        ],
      ),
    );
  }

  // 통계 아이템 생성 함수
  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Color(0xFF1F2024),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF232323),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // 도전 과제 아이템 생성 함수
  Widget _buildChallengeItem(String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Color(0xFFD9D9D9),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Color(0xFFB2B99E),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
