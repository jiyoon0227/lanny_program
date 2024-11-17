//챕터 정보 및 단어 배열 관리

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database.dart';

class ChapterTable {
  final dbHelper = DatabaseHelper();

  Future<void> insertChapter(Map<String, dynamic> chapterData) async {
    final db = await dbHelper.database;
    await db.insert('chapter_table', chapterData, conflictAlgorithm: ConflictAlgorithm.replace);
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

class ChapterWordsTable {
  final dbHelper = DatabaseHelper();

  Future<void> insertWordsForChapter(int chapterId, String wordsJson) async {
    final db = await dbHelper.database;
    await db.insert(
      'chapter_words_table',
      {'chapter_id': chapterId, 'words_json': wordsJson},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getWordsForChapter(int chapterId) async {
    final db = await dbHelper.database;
    final result = await db.query(
      'chapter_words_table',
      where: 'chapter_id = ?',
      whereArgs: [chapterId],
    );
    if (result.isNotEmpty) {
      return result.first['words_json'] as String;
    }
    return null;
  }
}
