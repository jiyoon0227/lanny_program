//사용자의 학습 기록, 진행 상황 관리 동적 모델

class Session {
  final int sessionId;
  final String userId;
  final int chapterId;
  final String startTime;
  final String endTime;
  final int state;
  final int amount;

  Session({
    required this.sessionId,
    required this.userId,
    required this.chapterId,
    required this.startTime,
    required this.endTime,
    required this.state,
    required this.amount,
  });

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      sessionId: map['session_id'],
      userId: map['user_id'],
      chapterId: map['chapter_id'],
      startTime: map['session_start_time'],
      endTime: map['session_end_time'],
      state: map['session_state'],
      amount: map['session_amount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'session_id': sessionId,
      'user_id': userId,
      'chapter_id': chapterId,
      'session_start_time': startTime,
      'session_end_time': endTime,
      'session_state': state,
      'session_amount': amount,
    };
  }
}
