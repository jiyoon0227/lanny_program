import 'package:flutter/material.dart';
import '../widgets/stop_popup.dart';

class LearnScreen4 extends StatefulWidget {
  final List<Map<String, String>> chapterWords;

  LearnScreen4({required this.chapterWords}); // Accept chapterWords via constructor

  @override
  _LearnScreen4State createState() => _LearnScreen4State();
}

class _LearnScreen4State extends State<LearnScreen4> {
  Color _button1Color = Colors.transparent;
  Color _button2Color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    // Accessing chapterWords to get the current word data
    final currentWord = widget.chapterWords[0]; // Accessing the first word for this screen

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DefaultTextStyle(
        style: TextStyle(
          color: Colors.black, // Default text color
          fontSize: 16, // Default font size
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
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
              ],
            ),
            SizedBox(height: 16),
            // Pause button
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.pause, color: Colors.grey),
                onPressed: () {
                  // PausePopup display
                  showDialog(
                    context: context,
                    builder: (context) => PausePopup(),
                  );
                },
              ),
            ),
            SizedBox(height: 50),
            // T-shirt image
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                currentWord['image']!, // Dynamically use the image from chapterWords
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(height: 16),
            // Korean text (using dynamic data from chapterWords)
            Text(
              currentWord['word_kr']!, // Dynamically use the Korean translation
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            // Button 1 (dynamically generated text)
            GestureDetector(
              onTap: () {
                setState(() {
                  _button1Color = _button1Color == Colors.transparent
                      ? Colors.green.withOpacity(0.5)
                      : Colors.transparent;
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
                      currentWord['word_jp']!, // Dynamically use Japanese word
                      style: TextStyle(
                        color: _button1Color == Colors.transparent ? Colors.black : Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '(${currentWord['pronunciation']})', // Dynamically use pronunciation
                      style: TextStyle(
                        color: _button1Color == Colors.transparent ? Colors.grey : Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Button 2 (dynamically generated text)
            GestureDetector(
              onTap: () {
                setState(() {
                  _button2Color = _button2Color == Colors.transparent
                      ? Colors.green.withOpacity(0.5)
                      : Colors.transparent;
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
                      widget.chapterWords[1]['word_jp']!, // Accessing the second word dynamically
                      style: TextStyle(
                        color: _button2Color == Colors.transparent ? Colors.black : Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '(${widget.chapterWords[1]['pronunciation']})', // Using dynamic pronunciation
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
            // Answer submission button
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 200, // Button width
                child: ElevatedButton(
                  onPressed: () {
                    // Logic when answer is submitted
                    print('Answer submitted');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    backgroundColor: Colors.green, // Button background color
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
    );
  }
}
