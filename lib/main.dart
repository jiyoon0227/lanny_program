import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';

void main() => runApp(lanny_program());

class lanny_program extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFFAF9F7), // 기본 배경색 설정
      ),
      themeMode: ThemeMode.light, // 강제 라이트 모드
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        '/login': (context) => login_screen(),
        '/signup': (context) => signup_screen(),
      },
    );
  }
}
