import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey, // 회색 원으로 대체
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.favorite, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  '2',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.black),
                const SizedBox(width: 8),
                Text(
                  '0 / 15',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(7, (index) {
                        return _buildChapterSection(index);
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildContinueTile(),
              ],
            ),
          ),
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildChapterSection(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 10),// Vertical line with circle
        Column(
          children: [
            Container(
              width: 2,
              height: 30,
              color: Colors.grey,
            ),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
            ),
            Container(
              width: 2,
              height: 90,
              color: Colors.grey,
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildChapterTile(
              "챕터 ${index + 2} - ${_getChapterTitle(index)}",
              "설명 텍스트를 여기에 추가하세요."),
        ),
        const SizedBox(width: 25),
      ],
    );
  }

  Widget _buildChapterTile(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      width: 300, // 너비 조정
      decoration: BoxDecoration(
        color: Color(0xFF4FA55B),
        borderRadius: BorderRadius.circular(40), // 곡률 통일
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 8, // 게이지 두께 조절
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: LinearProgressIndicator(
                    value: 0.5,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.arrow_forward, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContinueTile() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 80.0), // 하단바 위에 위치
      decoration: BoxDecoration(
        color: Color(0xFF4FA55B),
        borderRadius: BorderRadius.circular(50), // 곡률 통일
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12), // 사각형 모양으로 변경
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '이어서 하기 챕터 2 - 옷',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white), // 게이지 오른쪽 아이콘 추가
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 80,
        color: Color(0xFFFAF9F7),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 1),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home, color: Colors.green),
                Text('홈', style: TextStyle(color: Colors.green)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.repeat, color: Colors.grey),
                Text('복습', style: TextStyle(color: Colors.grey)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person, color: Colors.grey),
                Text('마이페이지', style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }

  String _getChapterTitle(int index) {
    switch (index) {
      case 0:
        return '옷';
      case 1:
        return '날씨';
      case 2:
        return '여행';
      case 3:
        return '음식';
      case 4:
        return '동물';
      case 5:
        return '가족';
      case 6:
        return '스포츠';
      default:
        return '기타';
    }
  }
}
