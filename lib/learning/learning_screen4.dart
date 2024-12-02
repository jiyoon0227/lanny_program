import 'package:flutter/material.dart';
import '../widgets/stop_popup.dart';

class LearnScreen4 extends StatefulWidget {
  final List<Map<String, String>> chapterWords;
  final int currentWordIndex;
  final Function(int) onProgressUpdated;
  final int progressCount;

  LearnScreen4({
    required this.chapterWords,
    required this.currentWordIndex,
    required this.onProgressUpdated,
    required this.progressCount,
  });

  @override
  _LearnScreen4State createState() => _LearnScreen4State();
}

class _LearnScreen4State extends State<LearnScreen4> {
  Color _button1Color = Colors.transparent;
  Color _button2Color = Colors.transparent;

  late int _randomIndex1;
  late int _randomIndex2;

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

  @override
  Widget build(BuildContext context) {
    final currentWord = widget.chapterWords[widget.currentWordIndex];
    final progressValue = (widget.progressCount + 1) / 15;

    final randomWord1 = widget.chapterWords[_randomIndex1];
    final randomWord2 = widget.chapterWords[_randomIndex2];

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView( // 내용이 길어질 경우 스크롤 가능
            padding: const EdgeInsets.all(16.0),
            child: DefaultTextStyle(
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 진행 상태와 버튼
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
                  // 이미지 표시
                  Center(
                    child: Image.asset(
                      currentWord['image']!,
                      width: 150,
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 16),
                  // 단어 원본 텍스트
                  Text(
                    currentWord['original']!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30), // 간격 축소

                  // 첫 번째 선택지 버튼
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _button1Color = Colors.green.withOpacity(0.5);
                        _button2Color = Colors.transparent; // 다른 버튼 초기화
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
                            randomWord1['translated']!,
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
                        _button2Color = Colors.green.withOpacity(0.5);
                        _button1Color = Colors.transparent; // 다른 버튼 초기화
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

                  // 답안 제출 버튼
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          print('Answer submitted');
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
            top: 50,  // 상단 진행 상태 바 바로 아래에 배치
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
