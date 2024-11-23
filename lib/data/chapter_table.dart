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
            'chapter_id': chapter['id'],
            'chapter_name': chapter['name'],
            'chapter_description': chapter['description'],
            'progress': chapter['progress'],
            'chapter_icon': chapter['icon'],
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

  // 단어 테이블 초기화 (예제용)
  Future<void> initializeWordTable() async {
    final db = await dbHelper.database;

    // 단어 데이터 초기화
    await db.execute('DELETE FROM word_table');
    await insertChapterWords(1, [
      {'word': 'はんそで', 'translation': '티셔츠', 'image': 'assets/images/chap1_tshirt.png'},
      {'word': 'ズボン', 'translation': '바지', 'image': 'assets/images/chap1_pants.png'},
      {'word': 'コート', 'translation': '코트', 'image': 'assets/images/chap1_coat.png'},
    ]);

    await insertChapterWords(2, [
      {'word': 'あめ', 'translation': '비', 'image': 'assets/images/chap2_rain.png'},
      {'word': 'はれ', 'translation': '맑음', 'image': 'assets/images/chap2_sunny.png'},
      {'word': 'ゆき', 'translation': '눈', 'image': 'assets/images/chap2_snow.png'},
    ]);
  }
}
