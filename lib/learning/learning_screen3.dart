import 'package:flutter/material.dart';
import '../widgets/stop_popup.dart';
import 'package:lanny_program/widgets/fail_answer_popup.dart'; // FailAnswerPopup 파일을 import하세요.
import 'package:lanny_program/widgets/correct_answer_popup.dart'; // CorrectAnswerPopup 파일도 추가

class LearnScreen3 extends StatefulWidget {
  final List<Map<String, String>> chapterWords;
  final int currentWordIndex;
  final Function(int) onProgressUpdated;
  final int progressCount;

  LearnScreen3({
    required this.chapterWords,
    required this.currentWordIndex,
    required this.onProgressUpdated,
    required this.progressCount,
  });

  @override
  _LearnScreen3State createState() => _LearnScreen3State();
}

class _LearnScreen3State extends State<LearnScreen3> {
  Color _topTextBackgroundColor = Colors.transparent;
  Color _bottomTextBackgroundColor = Colors.transparent;
  late List<int> _availableIndexes;
  late int _randomIndex;

  String? selectedWord; // 선택된 단어를 저장

  @override
  void initState() {
    super.initState();
    _resetAvailableIndexes();
    _randomIndex = _getRandomIndex(); // 랜덤 단어 초기화
  }

  void _resetAvailableIndexes() {
    _availableIndexes = List.generate(widget.chapterWords.length, (index) => index)
      ..remove(widget.currentWordIndex);
  }

  int _getRandomIndex() {
    if (_availableIndexes.isEmpty) _resetAvailableIndexes();
    _availableIndexes.shuffle();
    return _availableIndexes.removeLast();
  }

  @override
  Widget build(BuildContext context) {
    final currentWord = widget.chapterWords[widget.currentWordIndex];
    final randomWord = widget.chapterWords[_randomIndex];
    final progressValue = (widget.progressCount + 1) / 15;

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
                  // 상단 진행 바 및 버튼
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
                            '${widget.progressCount + 1}/15',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward, color: Colors.grey),
                            onPressed: () {
                              widget.onProgressUpdated(widget.currentWordIndex + 1);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                  SizedBox(height: 100),

                  // 현재 단어 영역
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedWord = currentWord['translated']; // 선택된 단어를 저장
                        _topTextBackgroundColor = Colors.green.withOpacity(0.5);
                        _bottomTextBackgroundColor = Colors.transparent; // 다른 단어 배경 초기화
                      });
                    },
                    child: Center(
                      child: Container(
                        color: _topTextBackgroundColor,
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              currentWord['translated']!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '(${currentWord['romanized']})',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),

                  // 이미지
                  Center(
                    child: Image.asset(
                      currentWord['image']!,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  SizedBox(height: 50),

                  // 랜덤 단어 영역
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedWord = randomWord['translated']; // 선택된 단어를 저장
                        _bottomTextBackgroundColor = Colors.green.withOpacity(0.5);
                        _topTextBackgroundColor = Colors.transparent; // 다른 단어 배경 초기화
                      });
                    },
                    child: Center(
                      child: Container(
                        color: _bottomTextBackgroundColor,
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              randomWord['translated']!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '(${randomWord['romanized']})',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 50),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedWord == currentWord['translated']) {
                            showDialog(
                              context: context,
                              builder: (context) => CorrectAnswerPopup(
                                imagePath: currentWord['image']!,
                                originalText: currentWord['original']!,
                                translatedText: currentWord['translated']!,
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => FailAnswerPopup(
                                imagePath: currentWord['image']!,
                                originalText: currentWord['original']!,
                                translatedText: currentWord['translated']!,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          backgroundColor: Colors.green,
                        ),
                        child: Text(
                          '답안 제출',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 일시정지 버튼을 화면 좌측 상단에 고정
          Positioned(
            left: 16,
            top: 50, // 상단 진행 상태 바 바로 아래에 배치
            child: IconButton(
              icon: Icon(Icons.pause, color: Colors.grey),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => PausePopup(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
