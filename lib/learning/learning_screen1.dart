import 'package:flutter/material.dart';
import '../widgets/stop_popup.dart';

class LearnScreen1 extends StatelessWidget {
  final List<Map<String, String>> chapterWords;
  final int currentWordIndex;
  final Function(int) onProgressUpdated;
  final int progressCount; // 추가
  final int chapterId;
  LearnScreen1({
    required this.chapterWords,
    required this.currentWordIndex,
    required this.onProgressUpdated,
    required this.progressCount, // 추가
    required this.chapterId,
  });

  @override
  Widget build(BuildContext context) {
    final currentWord = chapterWords[currentWordIndex];
    final progressValue = (progressCount + 1) / 15; // 학습 진행도 계산

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DefaultTextStyle(
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 상단 진행 바와 버튼들
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: progressValue,
                              backgroundColor: Colors.grey,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${progressCount + 1}/15',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward, color: Colors.grey),
                            onPressed: () {
                              onProgressUpdated(currentWordIndex + 1);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                  SizedBox(height: 40),

                  // 단어 학습 영역
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            currentWord['word_img']!,
                            height: 300,
                          ),
                          SizedBox(height: 16),
                          Text(
                            currentWord['korean_word']!,
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '(${currentWord['romanized_word']})',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            currentWord['translated_word']!,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),

          // 일시정지 버튼을 화면 좌측 상단에 고정
          Positioned(
            left: 16,
            top: 50,  // 상단 진행 상태 바 바로 아래에 배치
            child: IconButton(
              icon: Icon(Icons.pause, color: Colors.grey),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => PausePopup(
                    chapterId: chapterId,
                    progressCount: progressCount, // 진행도 전달
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
