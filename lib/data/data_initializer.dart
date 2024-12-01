import 'chapter_table.dart';
import 'word_table.dart';
import 'user_table.dart';

class DataInitializer {
  final ChapterTable chapterTable = ChapterTable();
  final WordTable wordTable = WordTable();
  final UserTable userTable = UserTable();

  // 챕터별 단어 데이터
  static final Map<int, List<Map<String, String>>> chapterWords = {
    1: [
      {'original': '빵', 'translated': 'bread', 'romanized': 'ppang', 'image': 'assets/images/chapter_imgs/chap1_bread.png'},
      {'original': '물', 'translated': 'water', 'romanized': 'mul', 'image': 'assets/images/chapter_imgs/chap1_water.png'},
      {'original': '밥', 'translated': 'rice', 'romanized': 'bap', 'image': 'assets/images/chapter_imgs/chap1_rice.png'},
      {'original': '고기', 'translated': 'meat', 'romanized': 'gogi', 'image': 'assets/images/chapter_imgs/chap1_meat.png'},
      {'original': '채소', 'translated': 'vegetables', 'romanized': 'chaeso', 'image': 'assets/images/chapter_imgs/chap1_vegetable.png'},
    ],
    2: [
      {'original': '티셔츠', 'translated': 't-shirt', 'romanized': 'tisyeocheu', 'image': 'assets/images/chapter_imgs/chap2_tshirt.png'},
      {'original': '바지', 'translated': 'pants', 'romanized': 'baji', 'image': 'assets/images/chapter_imgs/chap2_pants.png'},
      {'original': '코트', 'translated': 'coat', 'romanized': 'koteu', 'image': 'assets/images/chapter_imgs/chap2_coat.png'},
      {'original': '신발', 'translated': 'shoes', 'romanized': 'sinbal', 'image': 'assets/images/chapter_imgs/chap2_shoes.png'},
      {'original': '양말', 'translated': 'socks', 'romanized': 'yangmal', 'image': 'assets/images/chapter_imgs/chap2_socks.png'},
    ],
    3: [
      {'original': '구름', 'translated': 'cloud', 'romanized': 'gureum', 'image': 'assets/images/chapter_imgs/chap3_cloud.png'},
      {'original': '비', 'translated': 'rain', 'romanized': 'bi', 'image': 'assets/images/chapter_imgs/chap3_rain.png'},
      {'original': '눈', 'translated': 'snow', 'romanized': 'nun', 'image': 'assets/images/chapter_imgs/chap3_snow.png'},
      {'original': '바람', 'translated': 'wind', 'romanized': 'baram', 'image': 'assets/images/chapter_imgs/chap3_windi.png'},
      {'original': '태양', 'translated': 'sun', 'romanized': 'taeyang', 'image': 'assets/images/chapter_imgs/chap_sun.png'},
    ],
    4: [
      {'original': '호텔', 'translated': 'hotel', 'romanized': 'hotel', 'image': 'assets/images/chapter_imgs/chap4_hotel.png'},
      {'original': '여권', 'translated': 'passport', 'romanized': 'yeogwon', 'image': 'assets/images/chapter_imgs/chap4_passport.png'},
      {'original': '기념품', 'translated': 'souvenir', 'romanized': 'ginyeompum', 'image': 'assets/images/chapter_imgs/chap4_gift.png'},
      {'original': '약국', 'translated': 'pharmacy', 'romanized': 'yakguk', 'image': 'assets/images/chapter_imgs/chap4_pill.png'},
      {'original': '가방', 'translated': 'luggage', 'romanized': 'gabang', 'image': 'assets/images/chapter_imgs/chap4_luggage.png'},
    ],
    5: [
      {'original': '축제', 'translated': 'festival', 'romanized': 'chukje', 'image': 'assets/images/chapter_imgs/chap5_festival.png'},
      {'original': '종교', 'translated': 'religion', 'romanized': 'jonggyo', 'image': 'assets/images/chapter_imgs/chap5_religion.png'},
      {'original': '명절', 'translated': 'holiday', 'romanized': 'myeongjeol', 'image': 'assets/images/chapter_imgs/chap5_holiday.png'},
      {'original': '미술', 'translated': 'art', 'romanized': 'misul', 'image': 'assets/images/chapter_imgs/chap5_art.png'},
      {'original': '예절', 'translated': 'manners', 'romanized': 'yejeol', 'image': 'assets/images/chapter_imgs/chap5_etiquette.png'},
    ],
    6: [
      {'original': '안녕하세요', 'translated': 'hello', 'romanized': 'annyeonghaseyo', 'image': 'assets/images/chapter_imgs/chap6_hi.png'},
      {'original': '안녕히 가세요', 'translated': 'goodbye', 'romanized': 'annyeonghi gaseyo', 'image': 'assets/images/chapter_imgs/chap6_bye.png'},
      {'original': '감사합니다', 'translated': 'thank you', 'romanized': 'gamsahamnida', 'image': 'assets/images/chapter_imgs/chap6_thanks.png'},
      {'original': '네', 'translated': 'yes', 'romanized': 'ne', 'image': 'assets/images/chapter_imgs/chap6_yes.png'},
      {'original': '아니요', 'translated': 'no', 'romanized': 'aniyo', 'image': 'assets/images/chapter_imgs/chap6_no.png'},
    ],
    7: [
      {'original': '이름', 'translated': 'name', 'romanized': 'ireum', 'image': 'assets/images/chapter_imgs/chap7_name.png'},
      {'original': '생일', 'translated': 'birthday', 'romanized': 'saengil', 'image': 'assets/images/chapter_imgs/chap7_birthday.png'},
      {'original': '국적', 'translated': 'nationality', 'romanized': 'gukjeok', 'image': 'assets/images/chapter_imgs/chap7_nationality.png'},
      {'original': '주소', 'translated': 'address', 'romanized': 'juso', 'image': 'assets/images/chapter_imgs/chap7_address.png'},
      {'original': '휴대폰 번호', 'translated': 'phone number', 'romanized': 'hyudaepon beonho', 'image': 'assets/images/chapter_imgs/chap7_phone_number.png'},
    ],
  };

  // 특정 챕터의 단어를 가져오는 메서드
  static List<Map<String, String>> getWordsForChapter(int chapterId) {
    return chapterWords[chapterId] ?? [];
  }
  // 초기 데이터 삽입
  Future<void> initializeData() async {
    print('데이터 초기화가 완료되었습니다!');
  }
  }

