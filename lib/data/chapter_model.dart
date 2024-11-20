//챕터 및 단어 콘텐츠 표현 데이터 모델
class ChapterModel {
  final int chapterId;
  final String chapterName;
  final String chapterIntro;
  final String chapterLevel; // 추가
  final String chapterIconSrc; // 추가
  final double progress;

  ChapterModel({
    required this.chapterId,
    required this.chapterName,
    required this.chapterIntro,
    required this.chapterLevel, // 추가
    required this.chapterIconSrc, // 추가
    required this.progress,
  });

  // 데이터베이스에서 객체 생성
  factory ChapterModel.fromMap(Map<String, dynamic> map) {
    return ChapterModel(
      chapterId: map['chapter_id'],
      chapterName: map['chapter_name'],
      chapterIntro: map['chapter_intro'],
      chapterLevel: map['chapter_level'], // 추가
      chapterIconSrc: map['chapter_icon_src'], // 추가
      progress: map['progress'],
    );
  }

  // 객체를 데이터베이스 형식으로 변환
  Map<String, dynamic> toMap() {
    return {
      'chapter_id': chapterId,
      'chapter_name': chapterName,
      'chapter_intro': chapterIntro,
      'chapter_level': chapterLevel, // 추가
      'chapter_icon_src': chapterIconSrc, // 추가
      'progress': progress,
    };
  }
}
