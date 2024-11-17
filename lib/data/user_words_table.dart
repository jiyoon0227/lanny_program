//사용자 단어 학습 상태
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database.dart';

class UserWordsTable {
  final dbHelper = DatabaseHelper();

  Future<void> insertOrUpdateUserWord(Map<String, dynamic> userWordData) async {
    final db = await dbHelper.database;
    await db.insert(
      'User_words_table',
      userWordData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getUserWords(String userId) async {
    final db = await dbHelper.database;
    return await db.query(
      'User_words_table',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> deleteUserWord(int userWordId) async {
    final db = await dbHelper.database;
    await db.delete(
      'User_words_table',
      where: 'user_word_id = ?',
      whereArgs: [userWordId],
    );
  }
}
