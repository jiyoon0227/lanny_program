import 'package:flutter/material.dart';
import '../widgets/stop_popup.dart';
import '../widgets/correct_answer_popup.dart'; // CorrectAnswerPopup 파일 import
import '../widgets/fail_answer_popup.dart'; // FailAnswerPopup 파일 import

class LearnScreen4 extends StatefulWidget {
  final List<Map<String, String>> chapterWords;
  final int currentWordIndex;
  final Function(int) onProgressUpdated;
  final int progressCount;
  final int chapterId;
  LearnScreen4({
    required this.chapterWords,
    required this.currentWordIndex,
    required this.onProgressUpdated,
    required this.progressCount,
    required this.chapterId,
  });

  @override
  _LearnScreen4State createState() => _LearnScreen4State();
}

class _LearnScreen4State extends State<LearnScreen4> {
  Color _button1Color = Colors.transparent;
  Color _button2Color = Colors.transparent;

  late int _randomIndex1;
  late int _randomIndex2;

  String? _selectedWord;

  @override
  void initState() {
    super.initState();
    _generateRandomIndexes(); // 랜덤 인덱스 초기화
  }

  void _generateRandomIndexes() {
    final totalWords = widget.chapterWords.length;
    final currentIndex = widget.currentWordIndex;

    List<int> availableIndexes = List.generate(totalWords, (index) => index)..remove(currentIndex);
    availableIndexes.shuffle();

    // 첫 번째 단어는 항상 currentWord
    _randomIndex1 = currentIndex;

    // 두 번째 단어는 남은 단어 중 랜덤 선택
    _randomIndex2 = availableIndexes.isNotEmpty ? availableIndexes.removeLast() : currentIndex;
  }

  void _submitAnswer() {
    final currentWord = widget.chapterWords[widget.currentWordIndex];
    if (_selectedWord == currentWord['translated_word']) {
      showDialog(
        context: context,
        builder: (context) => CorrectAnswerPopup(
          wordImgPath: currentWord['word_img']!,
          koreanWord: currentWord['korean_word']!,
          translatedWord: currentWord['translated_word']!,
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => FailAnswerPopup(
          wordImgPath: currentWord['word_img']!,
          koreanWord: currentWord['korean_word']!,
          translatedWord: currentWord['translated_word']!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentWord = widget.chapterWords[widget.currentWordIndex];
    final progressValue = (widget.progressCount + 1) / 15;

    final randomWord1 = widget.chapterWords[_randomIndex1];
    final randomWord2 = widget.chapterWords[_randomIndex2];

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: DefaultTextStyle(
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  Center(
                    child: Image.asset(
                      currentWord['word_img']!,
                      width: 150,
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    currentWord['korean_word']!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),

                  // 첫 번째 선택지 버튼
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedWord = randomWord1['translated_word'];
                        _button1Color = Colors.green.withOpacity(0.5);
                        _button2Color = Colors.transparent;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: _button1Color,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        children: [
                          Text(
                            randomWord1['translated_word']!,
                            style: TextStyle(
                              color: _button1Color == Colors.transparent ? Colors.black : Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '(${randomWord1['romanized_word']})',
                            style: TextStyle(
                              color: _button1Color == Colors.transparent ? Colors.grey : Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 두 번째 선택지 버튼
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedWord = randomWord2['translated_word'];
                        _button2Color = Colors.green.withOpacity(0.5);
                        _button1Color = Colors.transparent;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: _button2Color,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        children: [
                          Text(
                            randomWord2['translated_word']!,
                            style: TextStyle(
                              color: _button2Color == Colors.transparent ? Colors.black : Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '(${randomWord2['romanized_word']})',
                            style: TextStyle(
                              color: _button2Color == Colors.transparent ? Colors.grey : Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: _submitAnswer,
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

          Positioned(
            left: 16,
            top: 50,
            child: IconButton(
              icon: Icon(Icons.pause, color: Colors.grey),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => PausePopup(
                    chapterId: widget.chapterId,
                    progressCount: widget.progressCount,
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
