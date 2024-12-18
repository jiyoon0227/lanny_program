import 'package:sqflite/sqflite.dart';
import 'database.dart';

class WordTable {
  final dbHelper = DatabaseHelper();

  // 단어 삽입
  Future<void> insertWord(
      int chapterId, String koreanWord, String translatedWord, String romanizedWord, int wordOrder, String wordImg) async {
    final db = await dbHelper.database;

    await db.insert(
      'word_table',
      {
        'chapter_id': chapterId,
        'korean_word': koreanWord,
        'translated_word': translatedWord,
        'romanized_word': romanizedWord,
        'word_img': wordImg, // 이미지 경로 삽입
        'word_order': wordOrder,
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

          // 중복 확인
          List<Map<String, dynamic>> existing = await txn.query(
            'word_table',
            where: 'chapter_id = ? AND korean_word = ?',
            whereArgs: [chapterId, word['korean_word']],
          );

          // 중복이 없는 경우에만 삽입
          if (existing.isEmpty) {
            await txn.insert(
              'word_table',
              {
                'chapter_id': chapterId,
                'korean_word': word['korean_word'],
                'translated_word': word['translated_word'],
                'romanized_word': word['romanized_word'],
                'word_img': word['word_img'], // 이미지 경로 삽입
                'word_order': i + 1,
                'is_learned': 0,
              },
              conflictAlgorithm: ConflictAlgorithm.ignore,
            );
          }
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
      orderBy: 'word_order ASC', // 수정된 필드명 사용
    );
  }
// 모든 단어 조회
  Future<List<Map<String, dynamic>>> getAllWords() async {
    final db = await dbHelper.database;

    return await db.query('word_table');
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

  Future<void> updateWordTranslationByKorean({
    required String original,
    required String translated,
    required String romanized,
  }) async {
    final db = await dbHelper.database;

    await db.update(
      'word_table',
      {
        'translated_word': translated,
        'romanized_word': romanized,
      },
      where: 'korean_word = ?',
      whereArgs: [original],
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
