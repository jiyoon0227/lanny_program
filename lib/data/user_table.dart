class UserTable {
  static const createTable = '''
    CREATE TABLE tb_user (
      user_id TEXT PRIMARY KEY,
      user_email TEXT,
      user_name TEXT,
      user_birthday TEXT,
      user_password TEXT,
      user_profile_image TEXT,
      user_streak_count INTEGER,
      user_longest_streak_count INTEGER,
      user_total_attendance_count INTEGER,
      user_mastered_words_count INTEGER,
      user_daily_time_goal INTEGER,
      user_daily_time_state INTEGER,
      user_notification_time TEXT
    );
  ''';

// CRUD 메서드 정의
// 예: insertUser, getUser, updateUser, deleteUser
}
