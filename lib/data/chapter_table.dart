import 'package:sqflite/sqflite.dart';
import 'database.dart';

class ChapterTable {
  final dbHelper = DatabaseHelper();

  // 챕터 정보 삽입
  Future<void> insertChapter(
      int chapterId, String name, String description, double progress, String chapterIcon) async {
    final db = await dbHelper.database;

    await db.insert(
      'chapter_table',
      {
        'chapter_id': chapterId,
        'chapter_name': name,
        'chapter_description': description,
        'progress': progress,
        'chapter_icon': chapterIcon,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 모든 챕터 정보 대량 삽입
  Future<void> insertChapters(List<Map<String, dynamic>> chapters) async {
    final db = await dbHelper.database;

    await db.transaction((txn) async {
      for (final chapter in chapters) {
        await txn.insert(
          'chapter_table',
          {
            'chapter_id': chapter['chapter_id'],
            'chapter_name': chapter['chapter_name'],
            'chapter_description': chapter['chapter_description'],
            'progress': chapter['progress'],
            'chapter_icon': chapter['chapter_icon'],
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  // 모든 챕터 조회
  Future<List<Map<String, dynamic>>> getAllChapters() async {
    final db = await dbHelper.database;

    return await db.query('chapter_table');
  }

  // 특정 챕터 조회
  Future<Map<String, dynamic>> getChapterById(int chapterId) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'chapter_table',
      where: 'chapter_id = ?',
      whereArgs: [chapterId],
    );

    return result.isNotEmpty ? result.first : {};
  }

  // 챕터 진행도 업데이트
  Future<void> updateChapterProgress(int chapterId, double progress) async {
    final db = await dbHelper.database;

    await db.update(
      'chapter_table',
      {'progress': progress},
      where: 'chapter_id = ?',
      whereArgs: [chapterId],
    );
  }

  // 챕터 ID별 단어 데이터 삽입
  Future<void> insertChapterWords(int chapterId, List<Map<String, String>> words) async {
    final db = await dbHelper.database;

    await db.transaction((txn) async {
      for (final word in words) {
        await txn.insert(
          'word_table',
          {
            'chapter_id': chapterId,
            'word': word['word'],
            'translation': word['translation'],
            'image': word['image'],
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  // 특정 챕터의 단어 데이터 조회
  Future<List<Map<String, String>>> getWordsForChapter(int chapterId) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'word_table',
      where: 'chapter_id = ?',
      whereArgs: [chapterId],
    );

    return result.map((e) => e.map((key, value) => MapEntry(key, value.toString()))).toList();
  }
}
