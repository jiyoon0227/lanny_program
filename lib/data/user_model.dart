//사용자 콘텐츠 표현 데이터 모델
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
  final int continuous;

  UserModel({
    required this.continuous,
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
      continuous: map['continuous'] ?? 0,
    );
  }
}


class UserData {
  final String id;
  final String password;
  final String uid;
  final String continuous;
  final String email;
  final String visitCounts;
  final String lastContinuousUpdate;


  UserData({
    required this.id,
    required this.password,
    required this.uid,
    required this.continuous,
    required this.email,
    required this.visitCounts,
    required this.lastContinuousUpdate
  });

  // Firestore 데이터에서 객체 생성
  factory UserData.fromFirestore(Map<String, dynamic> data, String documentId) {
    return UserData(
      id: data['ID'] ?? '',
      password: data['PassWord'] ?? '',
      uid: documentId, // Firestore document ID (UID)로 설정
      continuous: data['continuous'] ?? '',
      email: data['email'] ?? '',
      visitCounts: data['visitCounts'] ?? '',
      lastContinuousUpdate: data['lastContinuousUpdate'] ?? '',
    );
  }

  // 객체를 Map으로 변환 (Firestore 저장용)
  Map<String, dynamic> toFirestore() {
    return {
      'ID': id,
      'PassWord': password,
      'continuous': continuous,
      'email': email,
      'visitCounts': visitCounts,
      'lastContinuousUpdate' : lastContinuousUpdate,
    };
  }
}
