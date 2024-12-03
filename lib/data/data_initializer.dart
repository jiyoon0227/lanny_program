import 'chapter_table.dart';
import 'word_table.dart';
import 'user_table.dart';

class DataInitializer {
  final ChapterTable chapterTable = ChapterTable();
  final WordTable wordTable = WordTable();
  final UserTable userTable = UserTable();

  // 초기 데이터 삽입
  Future<void> initializeData() async {
    print('--- 데이터 초기화 시작 ---');

    try {
      print('유저 데이터 삽입 시작...');
      await userTable.insertUser(
        userId: 'default_user',
        userEmail: 'default_user@example.com',
        userName: 'Default User',
        userPassword: 'password123',
        userProfileImage: 'assets/images/default_profile.png',
        userSelectedLanguage: '한국어',
      );
      print('유저 데이터 삽입 완료.');
    } catch (e) {
      print('유저 데이터 삽입 중 오류 발생: $e');
    }

    try {
      print('챕터 데이터 삽입 시작...');
      await chapterTable.insertChapters([
        {'chapter_id': 1, 'chapter_name': '음식', 'chapter_description': '가장 기본적인 음식을 배워봅시다.', 'progress': 0.0,'chapter_icon': 'assets/images/chapter_imgs/chap1_icon_darkgray.png' },
        {'chapter_id': 2, 'chapter_name': '옷', 'chapter_description': '우리가 입고 있는 옷에 대해 배워봅시다.', 'progress': 0.0,'chapter_icon': 'assets/images/chapter_imgs/chap2_icon_darkgray.png'},
        {'chapter_id': 3, 'chapter_name': '날씨', 'chapter_description': '지금 하늘은 어떤 날씨인가요?', 'progress': 0.0,'chapter_icon': 'assets/images/chapter_imgs/chap3_icon_darkgray.png'},
        {'chapter_id': 4, 'chapter_name': '여행', 'chapter_description': '여행에서 꼭 필요한 단어에 대해 알아봅시다.', 'progress': 0.0,'chapter_icon': 'assets/images/chapter_imgs/chap4_icon_darkgray.png'},
        {'chapter_id': 5, 'chapter_name': '문화', 'chapter_description': '사회를 나타내는 문화 요소에는 어떤 것들이 있을까요?', 'progress': 0.0,'chapter_icon': 'assets/images/chapter_imgs/chap5_icon_darkgray.png'},
        {'chapter_id': 6, 'chapter_name': '인사', 'chapter_description': '인사법을 배우며 글로벌 매너를 익혀봅시다.', 'progress': 0.0,'chapter_icon': 'assets/images/chapter_imgs/chap6_icon_darkgray.png'},
        {'chapter_id': 7, 'chapter_name': '소속', 'chapter_description': '당신의 소속과 정보를 설명해보세요.', 'progress': 0.0,'chapter_icon': 'assets/images/chapter_imgs/chap7_icon_darkgray.png'},
      ]); // 기존 챕터 데이터 유지
      print('챕터 데이터 삽입 완료.');
    } catch (e) {
      print('챕터 데이터 삽입 중 오류 발생: $e');
    }

    try {
      print('단어 데이터 삽입 시작...');
      await wordTable.bulkInsertWords({
        1: [
          {'korean_word': '빵', 'translated_word': 'bread', 'romanized_word': 'ppang', 'word_img': 'assets/images/chapter_imgs/chap1_bread.png'},
          {'korean_word': '물', 'translated_word': 'water', 'romanized_word': 'mul', 'word_img': 'assets/images/chapter_imgs/chap1_water.png'},
          {'korean_word': '밥', 'translated_word': 'rice', 'romanized_word': 'bap', 'word_img': 'assets/images/chapter_imgs/chap1_rice.png'},
          {'korean_word': '고기', 'translated_word': 'meat', 'romanized_word': 'gogi', 'word_img': 'assets/images/chapter_imgs/chap1_meat.png'},
          {'korean_word': '채소', 'translated_word': 'vegetables', 'romanized_word': 'chaeso', 'word_img': 'assets/images/chapter_imgs/chap1_vegetable.png'},
        ],
        2: [
          {'korean_word': '티셔츠', 'translated_word': 't-shirt', 'romanized_word': 'tisyeocheu', 'word_img': 'assets/images/chapter_imgs/chap2_tshirt.png'},
          {'korean_word': '바지', 'translated_word': 'pants', 'romanized_word': 'baji', 'word_img': 'assets/images/chapter_imgs/chap2_pants.png'},
          {'korean_word': '코트', 'translated_word': 'coat', 'romanized_word': 'koteu', 'word_img': 'assets/images/chapter_imgs/chap2_coat.png'},
          {'korean_word': '신발', 'translated_word': 'shoes', 'romanized_word': 'sinbal', 'word_img': 'assets/images/chapter_imgs/chap2_shoes.png'},
          {'korean_word': '양말', 'translated_word': 'socks', 'romanized_word': 'yangmal', 'word_img': 'assets/images/chapter_imgs/chap2_socks.png'},
        ],
        3: [
          {'korean_word': '맑음', 'translated_word': 'clear', 'romanized_word': 'malgeum', 'word_img': 'assets/images/chapter_imgs/chap3_cloud.png'},
          {'korean_word': '구름', 'translated_word': 'cloud', 'romanized_word': 'gureum', 'word_img': 'assets/images/chapter_imgs/chap3_rain.png'},
          {'korean_word': '바람', 'translated_word': 'wind', 'romanized_word': 'baram', 'word_img': 'assets/images/chapter_imgs/chap3_snow.png'},
          {'korean_word': '비', 'translated_word': 'rain', 'romanized_word': 'bi', 'word_img': 'assets/images/chapter_imgs/chap3_windi.png'},
          {'korean_word': '눈', 'translated_word': 'snow', 'romanized_word': 'nun', 'word_img': 'assets/images/chapter_imgs/chap_sun.png'},
        ],
        4: [
          {'korean_word': '호텔', 'translated_word': 'hotel', 'romanized_word': 'hotel', 'word_img': 'assets/images/chapter_imgs/chap4_hotel.png'},
          {'korean_word': '관광', 'translated_word': 'tourism', 'romanized_word': 'gwangwang', 'word_img': 'assets/images/chapter_imgs/chap4_passport.png'},
          {'korean_word': '여권', 'translated_word': 'passport', 'romanized_word': 'yeogwon', 'word_img': 'assets/images/chapter_imgs/chap4_gift.png'},
          {'korean_word': '기념품', 'translated_word': 'souvenir', 'romanized_word': 'ginyeompum', 'word_img': 'assets/images/chapter_imgs/chap4_pill.png'},
          {'korean_word': '약국', 'translated_word': 'pharmacy', 'romanized_word': 'yakguk', 'word_img': 'assets/images/chapter_imgs/chap4_luggage.png'},
        ],
        5: [
          {'korean_word': '축제', 'translated_word': 'festival', 'romanized_word': 'chukje', 'word_img': 'assets/images/chapter_imgs/chap5_festival.png'},
          {'korean_word': '종교', 'translated_word': 'religion', 'romanized_word': 'jonggyo', 'word_img': 'assets/images/chapter_imgs/chap5_religion.png'},
          {'korean_word': '명절', 'translated_word': 'holiday', 'romanized_word': 'myeongjeol', 'word_img': 'assets/images/chapter_imgs/chap5_holiday.png'},
          {'korean_word': '미술', 'translated_word': 'art', 'romanized_word': 'misul', 'word_img': 'assets/images/chapter_imgs/chap5_art.png'},
          {'korean_word': '예절', 'translated_word': 'manners', 'romanized_word': 'yejeol', 'word_img': 'assets/images/chapter_imgs/chap5_etiquette.png'},
        ],
        6: [
          {'korean_word': '안녕하세요', 'translated_word': 'hello', 'romanized_word': 'annyeonghaseyo', 'word_img': 'assets/images/chapter_imgs/chap6_hi.png'},
          {'korean_word': '안녕히 가세요', 'translated_word': 'goodbye', 'romanized_word': 'annyeonghi gaseyo', 'word_img': 'assets/images/chapter_imgs/chap6_bye.png'},
          {'korean_word': '감사합니다', 'translated_word': 'thank you', 'romanized_word': 'gamsahamnida', 'word_img': 'assets/images/chapter_imgs/chap6_thanks.png'},
          {'korean_word': '네', 'translated_word': 'yes', 'romanized_word': 'ne', 'word_img': 'assets/images/chapter_imgs/chap6_yes.png'},
          {'korean_word': '아니요', 'translated_word': 'no', 'romanized_word': 'aniyo', 'word_img': 'assets/images/chapter_imgs/chap6_no.png'},
        ],
        7: [
          {'korean_word': '이름', 'translated_word': 'name', 'romanized_word': 'ireum', 'word_img': 'assets/images/chapter_imgs/chap7_name.png'},
          {'korean_word': '생일', 'translated_word': 'birthday', 'romanized_word': 'saengil', 'word_img': 'assets/images/chapter_imgs/chap7_birthday.png'},
          {'korean_word': '국적', 'translated_word': 'nationality', 'romanized_word': 'gukjeok', 'word_img': 'assets/images/chapter_imgs/chap7_nationality.png'},
          {'korean_word': '주소', 'translated_word': 'address', 'romanized_word': 'juso', 'word_img': 'assets/images/chapter_imgs/chap7_address.png'},
          {'korean_word': '휴대폰 번호', 'translated_word': 'phone number', 'romanized_word': 'hyudaepon beonho', 'word_img': 'assets/images/chapter_imgs/chap7_phone_number.png'},
        ],

      }); // 기존 단어 데이터 유지
      print('단어 데이터 삽입 완료.');
    } catch (e) {
      print('단어 데이터 삽입 중 오류 발생: $e');
    }

    print('--- 데이터 초기화 완료 ---');
  }

  // 디버깅 함수: 삽입된 데이터 확인
  Future<void> printDebugData() async {
    try {
      print('--- 챕터 데이터 확인 ---');
      final chapters = await chapterTable.getAllChapters();
      if (chapters.isEmpty) {
        print('챕터 데이터가 없습니다.');
      } else {
        for (var chapter in chapters) {
          print('챕터: ${chapter['chapter_name']}, 진행도: ${chapter['progress']}');
        }
      }
    } catch (e) {
      print('챕터 데이터 확인 중 오류 발생: $e');
    }
    }
  }

