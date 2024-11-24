import 'package:sqflite/sqflite.dart';
import 'database.dart';

class WordTable {
  final dbHelper = DatabaseHelper();

  // 단어 삽입
  Future<void> insertWord(
      int chapterId, String koreanWord, String translatedWord, String romanizedWord, int order) async {
    final db = await dbHelper.database;

    await db.insert(
      'word_table',
      {
        'chapter_id': chapterId,
        'korean_word': koreanWord,
        'translated_word': translatedWord,
        'romanized_word': romanizedWord,
        'order': order,
        'is_learned': 0, // 기본값: 학습되지 않음
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 대량 삽입 (챕터별 단어 삽입)
  Future<void> bulkInsertWords(Map<int, List<Map<String, String>>> chaptersWithWords) async {
    final db = await dbHelper.database;

    await db.transaction((txn) async {
      for (final chapterId in chaptersWithWords.keys) {
        final words = chaptersWithWords[chapterId]!;
        for (int i = 0; i < words.length; i++) {
          final word = words[i];
          await txn.insert(
            'word_table',
            {
              'chapter_id': chapterId,
              'korean_word': word['original'],
              'translated_word': word['translated'],
              'romanized_word': word['romanized'],
              'order': i + 1,
              'is_learned': 0,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }
    });
  }

  // 특정 챕터의 모든 단어 조회
  Future<List<Map<String, dynamic>>> getWordsForChapter(int chapterId) async {
    final db = await dbHelper.database;

    return await db.query(
      'word_table',
      where: 'chapter_id = ?',
      whereArgs: [chapterId],
      orderBy: 'order ASC', // 순서 기준 정렬
    );
  }

  // 단어 학습 상태 업데이트
  Future<void> updateWordStatus(int wordId, bool isLearned) async {
    final db = await dbHelper.database;

    await db.update(
      'word_table',
      {'is_learned': isLearned ? 1 : 0},
      where: 'id = ?',
      whereArgs: [wordId],
    );
  }

  // 단어 삭제
  Future<void> deleteWord(int wordId) async {
    final db = await dbHelper.database;

    await db.delete(
      'word_table',
      where: 'id = ?',
      whereArgs: [wordId],
    );
  }
}
