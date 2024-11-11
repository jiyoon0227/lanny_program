import 'package:flutter/material.dart';

class ChapterCoverPage extends StatelessWidget {
  final List<String> foreignWords = ['はんそで', 'ズボン', 'コート', 'くつ', 'くつした'];
  final List<String> koreanWords = ['티셔츠', '바지', '코트', '신발', '양말'];
  final List<String> wordImagePaths = [
    'assets/images/chapter_imgs/chap2_tshirt.png',
    'assets/images/chapter_imgs/chap2_pants.png',
    'assets/images/chapter_imgs/chap2_coat.png',
    'assets/images/chapter_imgs/chap2_shoes.png',
    'assets/images/chapter_imgs/chap2_socks.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAF9F7),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Color(0xFFEAEED1),
              expandedHeight: 150.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Color(0xFFEAEED1),
                ),
              ),
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '챕터 2 - 옷',
                    style: TextStyle(
                      color: Color(0xFF232323),
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '옷과 관련된 기본적인 어휘를 학습합니다.',
                    style: TextStyle(
                      color: Color(0xFFB2B99E),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Chip(
                        avatar: Image.asset(
                          'assets/images/chapcover_time.png',
                          width: 15,
                          height: 15,
                        ),
                        label: Text('5-8분'),
                        backgroundColor: Color(0xFFF1F3E8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
                      ),
                      SizedBox(width: 10),
                      Chip(
                        avatar: Image.asset(
                          'assets/images/chapcover_book.png',
                          width: 15,
                          height: 15,
                        ),
                        label: Text('5개'),
                        backgroundColor: Color(0xFFF1F3E8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: 0.2,
                    backgroundColor: Color(0xFFEAEED1),
                    color: Color(0xFF4FA55B),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '3/15',
                    style: TextStyle(
                      color: Color(0xFF4FA55B),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: foreignWords.length,
                itemBuilder: (context, index) {
                  return _buildWordItem(
                    foreignWords[index],
                    koreanWords[index],
                    wordImagePaths[index % wordImagePaths.length],
                    context,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4FA55B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  minimumSize: Size(double.infinity, 48),
                ),
                onPressed: () {},
                child: Text(
                  '학습시작',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWordItem(String title, String subtitle, String imagePath, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Image.asset(
          imagePath,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xFF232323),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Color(0xFFBDBDBD),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
