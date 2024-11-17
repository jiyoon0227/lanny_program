//도전 과제
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database.dart';

class AchievementTable {
  final dbHelper = DatabaseHelper();

  Future<void> insertAchievement(Map<String, dynamic> achievementData) async {
    final db = await dbHelper.database;
    await db.insert('achievement_table', achievementData, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAllAchievements() async {
    final db = await dbHelper.database;
    return await db.query('achievement_table');
  }

  Future<void> deleteAchievement(int achievementId) async {
    final db = await dbHelper.database;
    await db.delete(
      'achievement_table',
      where: 'achievement_id = ?',
      whereArgs: [achievementId],
    );
  }
}

class UserAchievementTable {
  final dbHelper = DatabaseHelper();

  Future<void> insertUserAchievement(Map<String, dynamic> userAchievementData) async {
    final db = await dbHelper.database;
    await db.insert('user_achievement_table', userAchievementData, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getUserAchievements(String userId) async {
    final db = await dbHelper.database;
    return await db.query(
      'user_achievement_table',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> updateUserAchievement(int challengeId, Map<String, dynamic> updatedData) async {
    final db = await dbHelper.database;
    await db.update(
      'user_achievement_table',
      updatedData,
      where: 'user_challenge_id = ?',
      whereArgs: [challengeId],
    );
  }
}
