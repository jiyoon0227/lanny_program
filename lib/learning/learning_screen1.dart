import 'package:flutter/material.dart';
import 'learning_screen2.dart';
import '../widgets/stop_popup.dart';

class LearnScreen1 extends StatelessWidget {
  final List<Map<String, String>> chapterWords; // 단어 리스트를 외부에서 전달받음

  LearnScreen1({required this.chapterWords}); // 생성자에서 단어 리스트를 받아옴

  @override
  Widget build(BuildContext context) {
    // 첫 번째 단어를 가져오기
    final currentWord = chapterWords[0];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DefaultTextStyle(
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 1 / 15,
                            backgroundColor: Colors.grey,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '1/15',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward, color: Colors.grey),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LearnScreen2(chapterWords: chapterWords),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
                Positioned(
                  left: 0,
                  top: 16,
                  child: Material(
                    type: MaterialType.transparency,
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
                ),
              ],
            ),
            SizedBox(height: 40),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      currentWord['image']!,
                      height: 300,
                    ),
                    SizedBox(height: 16),
                    Text(
                      currentWord['word_kr']!,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '(${currentWord['pronunciation']})',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      currentWord['word_jp']!,
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
    );
  }
}
