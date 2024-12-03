import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/stop_popup.dart';
import 'package:lanny_program/widgets/correct_answer_popup.dart';
import 'package:lanny_program/widgets/fail_answer_popup.dart';

class LearnScreen2 extends StatefulWidget {
  final List<Map<String, String>> chapterWords;
  final int currentWordIndex;
  final Function(int) onProgressUpdated;
  final int progressCount;

  LearnScreen2({
    required this.chapterWords,
    required this.currentWordIndex,
    required this.onProgressUpdated,
    required this.progressCount,
  });

  @override
  _LearnScreen2State createState() => _LearnScreen2State();
}

class _LearnScreen2State extends State<LearnScreen2> {
  final Random random = Random();
  late Map<String, String> currentWord;
  late Map<String, String> otherWord1;
  late Map<String, String> otherWord2;
  late Map<String, String> otherWord3;

  int? selectedIndex; // 선택된 이미지의 인덱스

  @override
  void initState() {
    super.initState();
    _initializeWords();
  }

  void _initializeWords() {
    setState(() {
      currentWord = widget.chapterWords[widget.currentWordIndex];
      final List<Map<String, String>> uniqueWords = _getUniqueRandomWords(3);
      otherWord1 = uniqueWords[0];
      otherWord2 = uniqueWords[1];
      otherWord3 = uniqueWords[2];
    });
  }

  List<Map<String, String>> _getUniqueRandomWords(int count) {
    final List<int> availableIndexes = List.generate(widget.chapterWords.length, (index) => index)
      ..remove(widget.currentWordIndex);

    availableIndexes.shuffle(random);

    return availableIndexes.take(count).map((index) => widget.chapterWords[index]).toList();
  }

  @override
  Widget build(BuildContext context) {
    final progressValue = (widget.progressCount + 1) / 15;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 상단 진행 상태 및 버튼
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
                      style: TextStyle(color: Colors.green, fontSize: 14),
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

                // 첫 번째 행: 2개의 이미지
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildImageTile(0, currentWord['image']!),
                    SizedBox(width: 20),
                    _buildImageTile(1, otherWord1['image']!),
                  ],
                ),
                SizedBox(height: 40),

                // 단어 텍스트
                Column(
                  children: [
                    Text(
                      currentWord['translated']!,
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '(${currentWord['romanized']})',
                      style: TextStyle(color: Colors.grey[400], fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 40),

                // 두 번째 행: 2개의 이미지
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildImageTile(2, otherWord2['image']!),
                    SizedBox(width: 20),
                    _buildImageTile(3, otherWord3['image']!),
                  ],
                ),
                SizedBox(height: 40),

                // 답안 제출 버튼
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 200, // Set a fixed width to match other screens
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedIndex != null) {
                          String selectedImage = '';
                          switch (selectedIndex) {
                            case 0:
                              selectedImage = currentWord['image']!;
                              break;
                            case 1:
                              selectedImage = otherWord1['image']!;
                              break;
                            case 2:
                              selectedImage = otherWord2['image']!;
                              break;
                            case 3:
                              selectedImage = otherWord3['image']!;
                              break;
                          }

                          // 정답/오답 확인
                          if (selectedImage == currentWord['image']!) {
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

  // 이미지 타일 위젯
  Widget _buildImageTile(int index, String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index; // 클릭된 이미지를 설정
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedIndex == index ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.all(8.0),
        child: Image.asset(
          imagePath,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}