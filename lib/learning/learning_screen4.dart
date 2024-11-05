import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            LearnScreen4(),
          ],
        ),
      ),
      routes: {
        '/learn4': (context) => LearnScreen4(),
      },
    ),
  );
}

class LearnScreen4 extends StatefulWidget {
  @override
  _LearnScreen4State createState() => _LearnScreen4State();
}

class _LearnScreen4State extends State<LearnScreen4> {
  Color _button1Color = Colors.transparent;
  Color _button2Color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DefaultTextStyle(
        style: TextStyle(
          color: Colors.black, // 기본 텍스트 색상
          fontSize: 16, // 기본 폰트 크기
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
                  // Functionality removed
                },
              ),
            ),
            SizedBox(height: 50),
            // T-shirt image
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/tshirt.png',
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(height: 16),
            // Korean text
            Text(
              '나는 바지를 입습니다.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            // Button 1
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
                      '私ははんそでを着ました。',
                      style: TextStyle(
                        color: _button1Color == Colors.transparent ? Colors.black : Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '(Watashi wa hansode o kimashita. )',
                      style: TextStyle(
                        color: _button1Color == Colors.transparent ? Colors.grey : Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Button 2
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
                      '私はくつしたを履きました。',
                      style: TextStyle(
                        color: _button2Color == Colors.transparent ? Colors.black : Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '(Watashi wa kutsushita o hakimashita.)',
                      style: TextStyle(
                        color: _button2Color == Colors.transparent ? Colors.grey : Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}