import 'package:sqflite/sqflite.dart';
import 'database.dart';

class UserTable {
  final dbHelper = DatabaseHelper();

  // 사용자 삽입
  Future<void> insertUser({
    required String userId,
    required String userEmail,
    required String userName,
    required String userPassword,
    String? userProfileImage,
    String? userSelectedLanguage,
    int userStreakCount = 0,
    int userLongestStreakCount = 0,
    int userTotalAttendanceCount = 0,
    int userMasteredWordsCount = 0,
  }) async {
    final db = await dbHelper.database;

    await db.insert(
      'user_table',
      {
        'user_id': userId,
        'user_email': userEmail,
        'user_name': userName,
        'user_password': userPassword,
        'user_profile_image': userProfileImage,
        'user_streak_count': userStreakCount,
        'user_longest_streak_count': userLongestStreakCount,
        'user_total_attendance_count': userTotalAttendanceCount,
        'user_mastered_words_count': userMasteredWordsCount,
        'user_selected_language': userSelectedLanguage,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 사용자 정보 업데이트
  Future<void> updateUser(String userId, Map<String, dynamic> updatedData) async {
    final db = await dbHelper.database;
    await db.update(
      'user_table',
      updatedData,
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  // 사용자 언어 설정 업데이트
  Future<void> updateUserLanguage(String userId, String language) async {
    final db = await dbHelper.database;
    await db.update(
      'user_table',
      {'user_selected_language': language},
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  // 특정 사용자의 정보 조회
  Future<Map<String, dynamic>?> getUser(String userId) async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> result = await db.query(
      'user_table',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  // 모든 사용자 정보 조회
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await dbHelper.database;
    return await db.query('user_table');
  }

  // 사용자 삭제
  Future<void> deleteUser(String userId) async {
    final db = await dbHelper.database;
    await db.delete(
      'user_table',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }
}

