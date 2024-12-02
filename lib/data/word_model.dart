// 단어 콘텐츠 표현 데이터 모델
class WordModel {
  final int wordId;
  final int chapterId;
  final String koreanWord;
  final String translatedWord;
  final String romanizedWord;
  final String wordImg;
  final int wordOrder;
  final bool isLearned;

  WordModel({
    required this.wordId,
    required this.chapterId,
    required this.koreanWord,
    required this.translatedWord,
    required this.romanizedWord,
    required this.wordImg,
    required this.wordOrder,
    required this.isLearned,
  });

  Map<String, dynamic> toMap() {
    return {
      'word_id': wordId,
      'chapter_id': chapterId,
      'korean_word': koreanWord,
      'translated_word': translatedWord,
      'romanized_word': romanizedWord,
      'word_img': wordImg,
      'word_order': wordOrder,
      'is_learned': isLearned ? 1 : 0,
    };
  }

  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      wordId: map['word_id'],
      chapterId: map['chapter_id'],
      koreanWord: map['korean_word'],
      translatedWord: map['translated_word'],
      romanizedWord: map['romanized_word'],
      wordImg: map['word_img'],
      wordOrder: map['order'],
      isLearned: map['is_learned'] == 1,
    );
  }
}