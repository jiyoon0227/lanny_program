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
  String continuous = '';
  String visitCounts = '';
  String selectedLanguage = '';
  List<Widget> dynamicChallengeItems = [];

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
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
            userName = '사용자';
            userEmail = userDoc['email'] ?? '이메일 없음';
            learningLanguage = userDoc['selectedLanguage'] ?? '언어 미지정';
            visitCounts = userDoc['visitCounts'] ?? '0';
            continuous = userDoc['continuous'] ?? '0';

            int continuousValue = int.tryParse(continuous) ?? 0;
            int visitCountsValue = int.tryParse(visitCounts) ?? 0;

            dynamicChallengeItems = [
              _buildChallengeItem('연속 출석 5일', continuousValue == 5 ? 1 : continuousValue),
              _buildChallengeItem('연속출석 갱신 3일', continuousValue == 3 ? 1 : continuousValue),
              _buildChallengeItem('연속출석 갱신 1일', continuousValue == 1 ? 1 : continuousValue),
              _buildChallengeItem('총 방문횟수 3일 이상', visitCountsValue >= 3 ? 3 : visitCountsValue),
            ];
          });
        }
      } else {
        print("Current user doesn't exist");
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
                showLogoutDialog(context);
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
          // 사용자 정보 섹션
          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Color(0xFFD9D9D9),
                backgroundImage: AssetImage('assets/images/Icon1.png'), // 이미지 경로
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
              _buildStatItem('총 방문 횟수', visitCounts),
              _buildStatItem('총 출석', '12일'),
              _buildStatItem('연속 방문 횟수', continuous),
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
              children: dynamicChallengeItems,
            ),
          ),

          SizedBox(height: 300),
          // 저작권 정보 위젯 추가
          Center(
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
          SizedBox(height: 120), // 하단 추가 간격
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
  Widget _buildChallengeItem(String label, [int count = 1]) {
    Color baseColor = Color(0xFFB2B99E);
    double opacity = (count * 0.2).clamp(0.0, 1.0); // 0.0 ~ 1.0 사이 값으로 조정
    Color newColor = baseColor.withOpacity(opacity);
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: newColor,
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: newColor,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
