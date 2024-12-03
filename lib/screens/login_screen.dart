import 'package:flutter/material.dart';
import 'package:lanny_program/data/user_model.dart';
import '../widgets/language_setting_popup.dart'; // 팝업 함수 임포트
import 'package:lanny_program/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lanny_program/FireStore/AuthService.dart';


class login_screen extends StatefulWidget {
  @override
  _login_screenState createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _continuousController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final AuthService _authService = AuthService();

  Future<void> _login()  async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      // Firebase Authentication으로 로그인
      UserCredential? userCredential =
      await _authService.loginWithEmailAndPassword(email, password);

      if (userCredential != null) {
        print("Login successful!");

        // Firestore에서 사용자 추가 데이터 가져오기
        fetchUserData(email);

        // visitCounts 'continuous' 업데이트
        await _authService.updateContinuousIfYesterday(email);

        // 로그인 성공 메시지
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login successful!")),
        );

        // 로그인 성공 시 회원가입 화면으로 이동
        Navigator.pushNamed(context, '/main');
      } else {
        // 로그인 실패 메시지
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed. Check your credentials.")),
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
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // 로그인 시도
                await _login();
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text('Go to Signup'),
            ),
          ],
        ),
      ),
    );
  }
}