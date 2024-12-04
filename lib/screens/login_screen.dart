import 'package:flutter/material.dart';
import 'package:lanny_program/data/user_model.dart';
import '../widgets/language_setting_popup.dart'; // 팝업 함수 임포트
import 'package:lanny_program/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lanny_program/FireStore/AuthService.dart';

class login_screen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<login_screen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final AuthService _authService = AuthService();

  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      // Firebase Authentication으로 로그인
      UserCredential? userCredential =
      await _authService.loginWithEmailAndPassword(email, password);

      if (userCredential != null) {
        print("Login successful!");

        // Firestore에서 사용자 추가 데이터 가져오기
        UserData? userData = await _authService.getUserDataByEmail(email);
        if (userData != null) {
          String userId = userData.id; // UserData 클래스의 id 필드 사용
          print("Fetched User ID (email): $userId");


        // visitCounts 'continuous' 업데이트
        await _authService.updateContinuousIfYesterday(email);


          // 'continuous' 업데이트
          await _authService.updateContinuousIfYesterday(email);

          // 로그인 성공 메시지
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login successful!")),
          );

          // 언어 설정 팝업 호출
          await showLanguageSettingPopup(context, userId);

          // 로그인 성공 시 메인 화면으로 이동
          Navigator.pushNamed(context, '/main');
        } else {
          print("User data not found in Firestore.");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User data not found.")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed. Cxheck your credentials.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter both email and password.")),
      );
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: '아이디',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4FA55B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                '로그인',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup'); // 회원가입 화면으로 이동
                },
                child: const Text(
                  '회원가입',
                  style: TextStyle(color: Color(0xFF4FA55B)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
