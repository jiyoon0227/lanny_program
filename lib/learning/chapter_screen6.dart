import 'package:flutter/material.dart';
import 'learning_screen1.dart'; // LearnScreen1 파일을 import합니다.

class ChapterScreen6 extends StatefulWidget {
  @override
  _ChapterScreen6State createState() => _ChapterScreen6State();
}

class _ChapterScreen6State extends State<ChapterScreen6> {
  // 하드코딩된 음식 챕터의 단어 리스트
  final List<Map<String, String>> chapterWords = [
    {
      'word_kr': '챕터6',
      'word_jp': 'りんご6',
      'pronunciation': 'apple',
      'image': 'assets/images/sun.png',
    },
    {
      'word_kr': '바나나',
      'word_jp': 'バナナ',
      'pronunciation': 'banana',
      'image': 'assets/images/bread.png',
    },
    {
      'word_kr': '티셔츠',
      'word_jp': 'Tシャツ',
      'pronunciation': 'Tshirt',
      'image': 'assets/images/tshirt.png',
    },
    {
      'word_kr': '양말',
      'word_jp': 'ソックス',
      'pronunciation': 'socks',
      'image': 'assets/images/socks.png',
    },
  ];
  final List<Map<String, String>> chapterSentence = [
    {
      'word_kr': '사과문장입니다',
      'word_jp': 'りんごりんごりんごりんご',
      'pronunciation': 'appleappleappleapple',
      'image': 'assets/images/sun.png',
    },
    // 추가적인 문장을 추가할 수 있습니다.
  ];


  @override
  void initState() {
    super.initState();
    // 화면이 로드되자마자 LearnScreen1으로 이동
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LearnScreen1(chapterWords: chapterWords),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // 이동 중 표시
      ),
    );
  }
}