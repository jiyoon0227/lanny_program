import 'package:flutter/material.dart';
import '../data/data_initializer.dart'; // DataInitializer 임포트
import '../screens/home_screen.dart';
import 'learning_screen1.dart';
import 'learning_screen2.dart';
import 'learning_screen3.dart';
import 'learning_screen4.dart';

class ChapterScreen1 extends StatefulWidget {
  final int chapterId; // 챕터 ID 추가

  ChapterScreen1({required this.chapterId}); // 생성자 수정

  @override
  _ChapterScreen1State createState() => _ChapterScreen1State();
}

class _ChapterScreen1State extends State<ChapterScreen1> {
  List<Map<String, String>> chapterWords = [];
  bool isLoading = true;

  int currentWordIndex = 0; // 현재 단어 인덱스
  int progressCount = 0; // 전체 학습 진행 카운트
  int currentScreenIndex = 0; // 현재 단어의 러닝스크린 순서 인덱스

  // 단어별 러닝스크린 순서 정의
  final List<List<Type>> learningSequence = [
    [LearnScreen1, LearnScreen2],
    [LearnScreen1, LearnScreen2, LearnScreen3],
    [LearnScreen1, LearnScreen2, LearnScreen3, LearnScreen4],
    [LearnScreen1, LearnScreen2, LearnScreen3, LearnScreen4, LearnScreen2],
    [LearnScreen1, LearnScreen2, LearnScreen3, LearnScreen4, LearnScreen2, LearnScreen3],
  ];

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  // 단어 데이터를 비동기로 로드
  Future<void> _loadWords() async {
    final words = await DataInitializer.getWordsForChapter(widget.chapterId);
    setState(() {
      chapterWords = words.take(5).toList(); // 필요한 단어만 가져오기
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Chapter ${widget.chapterId}')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (chapterWords.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Chapter ${widget.chapterId}')),
        body: Center(child: Text('단어 데이터가 없습니다.')),
      );
    }

    // 학습 완료 시 HomeScreen으로 이동
    if (progressCount >= 15) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/main'); // 홈 화면으로 이동
      });
      return SizedBox.shrink(); // 화면 전환 중 빈 화면 반환
    }

    // 현재 단어의 러닝스크린 순서 가져오기
    final currentSequence = learningSequence[currentWordIndex % learningSequence.length];
    final currentScreenType = currentSequence[currentScreenIndex];

    // 동적으로 러닝스크린 생성
    Widget currentScreen;
    if (currentScreenType == LearnScreen1) {
      currentScreen = LearnScreen1(
        chapterWords: chapterWords,
        currentWordIndex: currentWordIndex,
        progressCount: progressCount,
        onProgressUpdated: _updateProgressWithoutCount, // 카운트 증가 제외
      );
    } else if (currentScreenType == LearnScreen2) {
      currentScreen = LearnScreen2(
        chapterWords: chapterWords,
        currentWordIndex: currentWordIndex,
        progressCount: progressCount,
        onProgressUpdated: _updateProgressWithCount,
      );
    } else if (currentScreenType == LearnScreen3) {
      currentScreen = LearnScreen3(
        chapterWords: chapterWords,
        currentWordIndex: currentWordIndex,
        progressCount: progressCount,
        onProgressUpdated: _updateProgressWithCount,
      );
    } else if (currentScreenType == LearnScreen4) {
      currentScreen = LearnScreen4(
        chapterWords: chapterWords,
        currentWordIndex: currentWordIndex,
        progressCount: progressCount,
        onProgressUpdated: _updateProgressWithCount,
      );
    } else {
      throw Exception('Unknown screen type: $currentScreenType');
    }

    return currentScreen;
  }

  void _updateProgressWithoutCount(int newIndex) {
    setState(() {
      currentScreenIndex++;
      if (currentScreenIndex >= learningSequence[currentWordIndex % learningSequence.length].length) {
        currentScreenIndex = 0;
        currentWordIndex = (currentWordIndex + 1) % chapterWords.length;
      }
    });
  }

  void _updateProgressWithCount(int newIndex) {
    setState(() {
      progressCount++;
      currentScreenIndex++;
      if (currentScreenIndex >= learningSequence[currentWordIndex % learningSequence.length].length) {
        currentScreenIndex = 0;
        currentWordIndex = (currentWordIndex + 1) % chapterWords.length;
      }
    });
  }
}
