//학습 세션 정보
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database.dart';

class SessionTable {
  final dbHelper = DatabaseHelper();

  Future<void> insertSession(Map<String, dynamic> sessionData) async {
    final db = await dbHelper.database;
    await db.insert('session_table', sessionData, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getUserSessions(String userId) async {
    final db = await dbHelper.database;
    return await db.query(
      'session_table',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> deleteSession(int sessionId) async {
    final db = await dbHelper.database;
    await db.delete(
      'session_table',
      where: 'session_id = ?',
      whereArgs: [sessionId],
    );
  }
}
