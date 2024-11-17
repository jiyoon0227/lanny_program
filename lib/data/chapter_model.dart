//챕터 및 단어 콘텐츠 표현 데이터 모델
class Chapter {
  final int chapterId;
  final String name;
  final String level;
  final String? intro;
  final String? iconSrc;

  Chapter({
    required this.chapterId,
    required this.name,
    required this.level,
    this.intro,
    this.iconSrc,
  });

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      chapterId: map['chapter_id'],
      name: map['chapter_name'],
      level: map['chapter_level'],
      intro: map['chapter_intro'],
      iconSrc: map['chapter_icon_src'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chapter_id': chapterId,
      'chapter_name': name,
      'chapter_level': level,
      'chapter_intro': intro,
      'chapter_icon_src': iconSrc,
    };
  }
}
