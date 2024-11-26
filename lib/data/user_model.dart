//사용자 데이터 모델
class User {
  final String userId;
  final String email;
  final String name;
  final String? birthday;
  final String password;
  final String? profileImage;
  final int streakCount;
  final int longestStreak;
  final int totalAttendance;
  final int masteredWords;
  final int dailyTimeGoal;
  final int dailyTimeState;
  final String? notificationTime;

  User({
    required this.userId,
    required this.email,
    required this.name,
    this.birthday,
    required this.password,
    this.profileImage,
    required this.streakCount,
    required this.longestStreak,
    required this.totalAttendance,
    required this.masteredWords,
    required this.dailyTimeGoal,
    required this.dailyTimeState,
    this.notificationTime,
  });

  // 데이터베이스에서 가져온 데이터를 User 객체로 변환
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['user_id'],
      email: map['user_email'],
      name: map['user_name'],
      birthday: map['user_birthday'],
      password: map['user_password'],
      profileImage: map['user_profile_image'],
      streakCount: map['user_streak_count'],
      longestStreak: map['user_longest_streak_count'],
      totalAttendance: map['user_total_attendance_count'],
      masteredWords: map['user_mastered_words_count'],
      dailyTimeGoal: map['user_daily_time_goal'],
      dailyTimeState: map['user_daily_time_state'],
      notificationTime: map['user_notification_time'],
    );
  }

  // User 객체를 데이터베이스에 저장하기 위해 Map으로 변환
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'user_email': email,
      'user_name': name,
      'user_birthday': birthday,
      'user_password': password,
      'user_profile_image': profileImage,
      'user_streak_count': streakCount,
      'user_longest_streak_count': longestStreak,
      'user_total_attendance_count': totalAttendance,
      'user_mastered_words_count': masteredWords,
      'user_daily_time_goal': dailyTimeGoal,
      'user_daily_time_state': dailyTimeState,
      'user_notification_time': notificationTime,
    };
  }
}
