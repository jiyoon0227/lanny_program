//도전 과제 데이터 모델
class Achievement {
  final int achievementId;
  final String description;
  final String type;
  final int requirement;

  Achievement({
    required this.achievementId,
    required this.description,
    required this.type,
    required this.requirement,
  });

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      achievementId: map['achievement_id'],
      description: map['achievement_description'],
      type: map['achievement_type'],
      requirement: map['achievement_requirement'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'achievement_id': achievementId,
      'achievement_description': description,
      'achievement_type': type,
      'achievement_requirement': requirement,
    };
  }
}
