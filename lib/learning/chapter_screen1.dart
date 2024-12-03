import 'package:flutter/material.dart';
import '../data/chapter_table.dart'; // ChapterTable 임포트
import '../data/word_table.dart'; // 단어 테이블 임포트
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
  final ChapterTable chapterTable = ChapterTable(); // ChapterTable 인스턴스 생성
  final WordTable wordTable = WordTable(); // WordTable 인스턴스 추가
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
    try {
      final words = await chapterTable.getWordsForChapter(widget.chapterId);

      // null 값을 기본값으로 변환
      setState(() {
        chapterWords = words
            .map((word) => {
          'korean_word': word['korean_word'] ?? '', // null일 경우 빈 문자열
          'translated_word': word['translated_word'] ?? '',
          'romanized_word': word['romanized_word'] ?? '',
          'word_img': word['word_img'] ?? 'assets/images/default.png', // 기본 이미지 설정
        })
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print('단어 데이터를 불러오는 중 오류 발생: $e');
      setState(() {
        isLoading = false;
      });
    }
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
