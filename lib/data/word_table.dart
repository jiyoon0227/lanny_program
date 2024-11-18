//챕터별 단어 정보와 변환된 데이터를 저장

import 'package:sqflite/sqflite.dart';
import 'database.dart';

class WordTable {
  final dbHelper = DatabaseHelper();

  Future<void> insertWords(int chapterId, List<Map<String, String>> words) async {
    final db = await dbHelper.database;
    for (var word in words) {
      await db.insert(
        'word_table',
        {
          'chapter_id': chapterId,
          'korean_word': word['original'],
          'translated_word': word['translated'],
          'romanized_word': word['romanized'],
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getWordsForChapter(int chapterId) async {
    final db = await dbHelper.database;
    final result = await db.query(
      'word_table',
      where: 'chapter_id = ?',
      whereArgs: [chapterId],
    );
    return result;
  }
}

