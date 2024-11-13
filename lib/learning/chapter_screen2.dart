import 'package:flutter/material.dart';
import 'learning_screen1.dart'; // LearnScreen1 파일을 import합니다.

class ChapterScreen2 extends StatefulWidget {
  @override
  _ChapterScreen2State createState() => _ChapterScreen2State();
}

class _ChapterScreen2State extends State<ChapterScreen2> {
  // 하드코딩된 음식 챕터의 단어 리스트
  final List<Map<String, String>> chapterWords = [
    {
      'word_kr': '일본',
      'word_jp': '2りんご',
      'pronunciation': 'apple',
      'image': 'assets/images/sun.png',
    },
    {
      'word_kr': '중국',
      'word_jp': 'りんご',
      'pronunciation': 'banana',
      'image': 'assets/images/bread.png',
    },
    {
      'word_kr': '캐나다',
      'word_jp': 'りんご',
      'pronunciation': 'Tshirt',
      'image': 'assets/images/tshirt.png',
    },
    {
      'word_kr': '미국',
      'word_jp': 'りんご',
      'pronunciation': 'socks',
      'image': 'assets/images/socks.png',
    },
  ];
  final List<Map<String, String>> chapterCentence = [
    {
      'word_kr': '사과문장입니다',
      'word_jp': 'りんごりんごりんごりんご',
      'pronunciation': 'appleappleappleapple',
      'image': 'assets/images/sun.png',
    },
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
