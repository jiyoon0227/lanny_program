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
        '/learn4': (context) => LearnScreen4(), // LearnScreen4 추가
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

  void _showPauseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("일시정지"),
          content: Text("어떤 작업을 하시겠습니까?"),
          actions: <Widget>[
            TextButton(
              child: Text("중지하기"),
              onPressed: () {
                // 중지하기 동작
                Navigator.of(context).pop();
                print("중지하기 선택");
              },
            ),
            TextButton(
              child: Text("이어하기"),
              onPressed: () {
                // 이어하기 동작
                Navigator.of(context).pop();
                print("이어하기 선택");
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 6, // 60% 너비로 설정
                    child: LinearProgressIndicator(
                      value: 1 / 15,
                      backgroundColor: Colors.grey,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    flex: 4, // 남은 40%는 텍스트가 차지
                    child: Text(
                      '1/15',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                      ),
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
                  onPressed: _showPauseDialog,
                ),
              ),
              SizedBox(height: 50),
              // T-shirt image
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/tshirt.png', // 이미지 경로 확인
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
              // Button 1: English text and pronunciation
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
                    border: Border.all(color: Colors.grey), // 테두리 색상 추가
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
              // Button 2: Longer English text and pronunciation
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
                    border: Border.all(color: Colors.grey), // 테두리 색상 추가
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
        ],
      ),
    );
  }
}