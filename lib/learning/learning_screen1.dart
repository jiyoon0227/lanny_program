import 'package:flutter/material.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: learn_screen1(),
      ),
    );
  }
}

class learn_screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            clipBehavior: Clip.none,
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
                  Spacer(),
                ],
              ),
              // IconButton이 Stack의 마지막에 배치되어 가장 위로 그려지게 함
              Positioned(
                left: 0,
                bottom: -40,
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: Icon(Icons.pause, color: Colors.grey),
                    onPressed: () {
                      print('Pause button pressed');
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          Expanded(
            child: Row(
              children: [
                Spacer(flex: 1),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/tshirt.png',
                      height: 300,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'はんそで',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '(hansode)',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '티셔츠',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                Spacer(flex: 9),
              ],
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}