import 'package:sqflite/sqflite.dart';
import 'database.dart';

class ChapterTable {
  final dbHelper = DatabaseHelper();

  // 챕터 정보 삽입
  Future<void> insertChapter(
      int chapterId, String name, String intro, double progress) async {
    final db = await dbHelper.database;

    await db.insert(
      'chapter_table',
      {
        'chapter_id': chapterId,
        'chapter_name': name,
        'chapter_intro': intro,
        'progress': progress,
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
            'chapter_id': chapter['id'],
            'chapter_name': chapter['name'],
            'chapter_intro': chapter['intro'],
            'progress': chapter['progress'],
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
}
