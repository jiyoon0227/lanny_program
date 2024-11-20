//챕터 및 단어 콘텐츠 표현 데이터 모델
class ChapterModel {
  final int chapterId;
  final String chapterName;
  final String chapterDescription;
  final double progress;
  final String chapterIcon;

  ChapterModel({
    required this.chapterId,
    required this.chapterName,
    required this.chapterDescription,
    required this.progress,
    required this.chapterIcon,
  });

  Map<String, dynamic> toMap() {
    return {
      'chapter_id': chapterId,
      'chapter_name': chapterName,
      'chapter_description': chapterDescription,
      'progress': progress,
      'chapter_icon': chapterIcon,
    };
  }

  factory ChapterModel.fromMap(Map<String, dynamic> map) {
    return ChapterModel(
      chapterId: map['chapter_id'],
      chapterName: map['chapter_name'],
      chapterDescription: map['chapter_description'],
      progress: map['progress'],
      chapterIcon: map['chapter_icon'],
    );
  }
}

