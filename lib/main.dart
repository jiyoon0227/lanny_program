import 'package:flutter/material.dart';
import 'package:lanny_program/screens/home_screen.dart';
import 'package:lanny_program/screens/mypage_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/main_navigation_screen.dart';

void main() => runApp(LannyProgram());

class LannyProgram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFFAF9F7),
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: welcome_screen(), // 클래스명으로 수정
      routes: {
        '/login': (context) => login_screen(),   // 클래스명으로 수정
        '/signup': (context) => signup_screen(), // 클래스명으로 수정
        '/main': (context) => MainNavigationScreen(), // 클래스명으로 수정
      },
    );
  }
}