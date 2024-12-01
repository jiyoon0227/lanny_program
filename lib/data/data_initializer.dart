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
          {'korean_word': '빵', 'translated_word': 'bread', 'romanized_word': 'ppang'},
          {'korean_word': '물', 'translated_word': 'water', 'romanized_word': 'mul'},
          {'korean_word': '밥', 'translated_word': 'rice', 'romanized_word': 'bap'},
          {'korean_word': '고기', 'translated_word': 'meat', 'romanized_word': 'gogi'},
          {'korean_word': '채소', 'translated_word': 'vegetables', 'romanized_word': 'chaeso'},
        ],
        2: [
          {'korean_word': '티셔츠', 'translated_word': 't-shirt', 'romanized_word': 'tisyeocheu'},
          {'korean_word': '바지', 'translated_word': 'pants', 'romanized_word': 'baji'},
          {'korean_word': '코트', 'translated_word': 'coat', 'romanized_word': 'koteu'},
          {'korean_word': '신발', 'translated_word': 'shoes', 'romanized_word': 'sinbal'},
          {'korean_word': '양말', 'translated_word': 'socks', 'romanized_word': 'yangmal'},
        ],
        3: [
          // chap3: 날씨
          {'korean_word': '맑음', 'translated_word': 'clear', 'romanized_word': 'malgeum'},
          {'korean_word': '구름', 'translated_word': 'cloud', 'romanized_word': 'gureum'},
          {'korean_word': '바람', 'translated_word': 'wind', 'romanized_word': 'baram'},
          {'korean_word': '비', 'translated_word': 'rain', 'romanized_word': 'bi'},
          {'korean_word': '눈', 'translated_word': 'snow', 'romanized_word': 'nun'},
        ],
        4: [
          // chap4: 여행
          {'korean_word': '호텔', 'translated_word': 'hotel', 'romanized_word': 'hotel'},
          {'korean_word': '관광', 'translated_word': 'tourism', 'romanized_word': 'gwangwang'},
          {'korean_word': '여권', 'translated_word': 'passport', 'romanized_word': 'yeogwon'},
          {'korean_word': '기념품', 'translated_word': 'souvenir', 'romanized_word': 'ginyeompum'},
          {'korean_word': '약국', 'translated_word': 'pharmacy', 'romanized_word': 'yakguk'},
        ],
        5: [
          // chap5: 문화
          {'korean_word': '축제', 'translated_word': 'festival', 'romanized_word': 'chukje'},
          {'korean_word': '종교', 'translated_word': 'religion', 'romanized_word': 'jonggyo'},
          {'korean_word': '명절', 'translated_word': 'holiday', 'romanized_word': 'myeongjeol'},
          {'korean_word': '미술', 'translated_word': 'art', 'romanized_word': 'misul'},
          {'korean_word': '예절', 'translated_word': 'manners', 'romanized_word': 'yejeol'},
        ],
        6: [
          // chap6: 인사
          {'korean_word': '안녕하세요', 'translated_word': 'hello', 'romanized_word': 'annyeonghaseyo'},
          {'korean_word': '안녕히 가세요', 'translated_word': 'goodbye', 'romanized_word': 'annyeonghi gaseyo'},
          {'korean_word': '감사합니다', 'translated_word': 'thank you', 'romanized_word': 'gamsahamnida'},
          {'korean_word': '네', 'translated_word': 'yes', 'romanized_word': 'ne'},
          {'korean_word': '아니요', 'translated_word': 'no', 'romanized_word': 'aniyo'},
        ],
        7: [
          // chap7: 소속
          {'korean_word': '이름', 'translated_word': 'name', 'romanized_word': 'ireum'},
          {'korean_word': '생일', 'translated_word': 'birthday', 'romanized_word': 'saengil'},
          {'korean_word': '국적', 'translated_word': 'nationality', 'romanized_word': 'gukjeok'},
          {'korean_word': '주소', 'translated_word': 'address', 'romanized_word': 'juso'},
          {'korean_word': '휴대폰 번호', 'translated_word': 'phone number', 'romanized_word': 'hyudaepon beonho'}
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

