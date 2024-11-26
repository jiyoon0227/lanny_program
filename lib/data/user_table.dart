//사용자 정보
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database.dart';

class UserTable {
  final dbHelper = DatabaseHelper();

  Future<void> insertUser(Map<String, dynamic> userData) async {
    final db = await dbHelper.database;
    await db.insert('user_table', userData, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getUserById(String userId) async {
    final db = await dbHelper.database;
    final result = await db.query(
      'user_table',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<void> updateUser(String userId, Map<String, dynamic> updatedData) async {
    final db = await dbHelper.database;
    await db.update(
      'user_table',
      updatedData,
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> deleteUser(String userId) async {
    final db = await dbHelper.database;
    await db.delete(
      'user_table',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }
}

