import 'package:flutter/material.dart';
import 'package:lanny_program/screens/learn_screen2.dart';
import 'package:lanny_program/screens/learn_screen3.dart';
import 'package:lanny_program/screens/learn_screen4.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/learn_screen.dart'; // LearnScreen import

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
      home: LearnScreen4(),
      routes: {
        '/login': (context) => login_screen(),
        '/signup': (context) => signup_screen(),
        '/learn': (context) => learn_screen(), // LearnScreen 추가
        '/learn2': (context) => LearnScreen2(), // LearnScreen2 추가
        '/learn3': (context) =>  LearnScreen3(),// LearnScreen2 추가
        '/learn4': (context) =>  LearnScreen4()// LearnScreen2 추가
      },
    );
  }
}

