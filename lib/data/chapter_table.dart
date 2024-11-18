//챕터 정보 및 단어 배열 관리

import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database.dart';

class ChapterTable {
  final dbHelper = DatabaseHelper();

  // 챕터 삽입
  Future<void> insertChapter(String name, String level, String intro, String iconSrc) async {
    final db = await dbHelper.database;
    await db.insert(
      'chapter_table',
      {
        'chapter_name': name,
        'chapter_level': level,
        'chapter_intro': intro,
        'chapter_icon_src': iconSrc,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 단어 삽입
  Future<void> insertWordsForChapter(int chapterId, List<String> words) async {
    final db = await dbHelper.database;
    final wordsJson = jsonEncode(words); // 단어 목록을 JSON으로 변환
    await db.insert(
      'chapter_words_table',
      {
        'chapter_id': chapterId,
        'words_json': wordsJson,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllChapters() async {
    final db = await dbHelper.database;
    return await db.query('chapter_table');
  }

  Future<void> deleteChapter(int chapterId) async {
    final db = await dbHelper.database;
    await db.delete(
      'chapter_table',
      where: 'chapter_id = ?',
      whereArgs: [chapterId],
    );
  }
}

// 챕터와 단어를 일괄 등록
Future<void> registerChaptersAndWords() async {
  // ChapterTable 클래스의 인스턴스를 생성
  final chapterTable = ChapterTable();

  // 챕터 데이터
  List<String> chapterNames = ['음식', '옷', '날씨', '여행', '문화', '인사', '소속'];
  List<List<String>> chapterWords = [
    ['빵', '물', '밥', '고기', '채소'],
    ['티셔츠', '바지', '코트', '신발', '양말'],
    ['맑음', '구름', '바람', '비', '눈'],
    ['호텔', '관광', '여권', '기념품', '약국'],
    ['축제', '종교', '명절', '미술', '예절'],
    ['안녕하세요', '안녕히 가세요', '감사합니다', '네', '아니요'],
    ['이름', '생일', '국적', '주소', '휴대폰 번호']
  ];

  // 챕터 및 단어 등록
  for (int i = 0; i < chapterNames.length; i++) {
    // insertChapter 호출
    await chapterTable.insertChapter(
      chapterNames[i],
      '기본 레벨',
      '${chapterNames[i]}에 대한 설명입니다.',
      'assets/icons/chapter_${i + 1}.png',
    );

    // insertWordsForChapter 호출
    await chapterTable.insertWordsForChapter(i + 1, chapterWords[i]);
  }

  print('모든 챕터와 단어가 등록되었습니다!');
}


