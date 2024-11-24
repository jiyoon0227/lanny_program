// 사용자 콘텐츠 표현 데이터 모델
class UserModel {
  final String userId;
  final String userEmail;
  final String userName;
  final String userPassword;
  final String? userProfileImage;
  final String? userSelectedLanguage;
  final int userStreakCount;
  final int userLongestStreakCount;
  final int userTotalAttendanceCount;
  final int userMasteredWordsCount;

  UserModel({
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.userPassword,
    this.userProfileImage,
    this.userSelectedLanguage,
    this.userStreakCount = 0,
    this.userLongestStreakCount = 0,
    this.userTotalAttendanceCount = 0,
    this.userMasteredWordsCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'user_email': userEmail,
      'user_name': userName,
      'user_password': userPassword,
      'user_profile_image': userProfileImage,
      'user_selected_language': userSelectedLanguage,
      'user_streak_count': userStreakCount,
      'user_longest_streak_count': userLongestStreakCount,
      'user_total_attendance_count': userTotalAttendanceCount,
      'user_mastered_words_count': userMasteredWordsCount,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'],
      userEmail: map['user_email'],
      userName: map['user_name'],
      userPassword: map['user_password'],
      userProfileImage: map['user_profile_image'],
      userSelectedLanguage: map['user_selected_language'],
      userStreakCount: map['user_streak_count'] ?? 0,
      userLongestStreakCount: map['user_longest_streak_count'] ?? 0,
      userTotalAttendanceCount: map['user_total_attendance_count'] ?? 0,
      userMasteredWordsCount: map['user_mastered_words_count'] ?? 0,
    );
  }
}