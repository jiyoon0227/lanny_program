import 'chapter_table.dart';
import 'word_table.dart';

class DataInitializer {
  final ChapterTable chapterTable = ChapterTable();
  final WordTable wordTable = WordTable();

  // 초기 데이터 삽입
  Future<void> initializeData() async {
    // 1. 챕터 데이터 삽입
    await chapterTable.insertChapters([
      {'id': 1, 'name': '음식', 'description': '가장 기본적인 음식을 배워봅시다.', 'progress': 0.0,'icon': 'assets/images/chapter_imgs/chap1_icon_darkgray.png' },
      {'id': 2, 'name': '옷', 'description': '우리가 입고 있는 옷에 대해 배워봅시다.', 'progress': 0.0,'icon': 'assets/images/chapter_imgs/chap2_icon_darkgray.png'},
      {'id': 3, 'name': '날씨', 'description': '지금 하늘은 어떤 날씨인가요?', 'progress': 0.0,'icon': 'assets/images/chapter_imgs/chap3_icon_darkgray.png'},
      {'id': 4, 'name': '여행', 'description': '여행에서 꼭 필요한 단어에 대해 알아봅시다.', 'progress': 0.0,'icon': 'assets/images/chapter_imgs/chap4_icon_darkgray.png'},
      {'id': 5, 'name': '문화', 'description': '사회를 나타내는 문화 요소에는 어떤 것들이 있을까요?', 'progress': 0.0,'icon': 'assets/images/chapter_imgs/chap5_icon_darkgray.png'},
      {'id': 6, 'name': '인사', 'description': '인사법을 배우며 글로벌 매너를 익혀봅시다.', 'progress': 0.0,'icon': 'assets/images/chapter_imgs/chap6_icon_darkgray.png'},
      {'id': 7, 'name': '소속', 'description': '당신의 소속과 정보를 설명해보세요.', 'progress': 0.0,'icon': 'assets/images/chapter_imgs/chap7_icon_darkgray.png'},
    ]);

    // 2. 단어 데이터 삽입
    await wordTable.bulkInsertWords({
      1: [
        {'original': '빵', 'translated': 'bread', 'romanized': 'ppang'},
        {'original': '물', 'translated': 'water', 'romanized': 'mul'},
        {'original': '밥', 'translated': 'rice', 'romanized': 'bap'},
        {'original': '고기', 'translated': 'meat', 'romanized': 'gogi'},
        {'original': '채소', 'translated': 'vegetables', 'romanized': 'chaeso'},
      ],
      2: [
        {'original': '티셔츠', 'translated': 't-shirt', 'romanized': 'tisyeocheu'},
        {'original': '바지', 'translated': 'pants', 'romanized': 'baji'},
        {'original': '코트', 'translated': 'coat', 'romanized': 'koteu'},
        {'original': '신발', 'translated': 'shoes', 'romanized': 'sinbal'},
        {'original': '양말', 'translated': 'socks', 'romanized': 'yangmal'},
      ],
      3: [
        // chap3: 날씨
        {'original': '맑음', 'translated': 'clear', 'romanized': 'malgeum'},
        {'original': '구름', 'translated': 'cloud', 'romanized': 'gureum'},
        {'original': '바람', 'translated': 'wind', 'romanized': 'baram'},
        {'original': '비', 'translated': 'rain', 'romanized': 'bi'},
        {'original': '눈', 'translated': 'snow', 'romanized': 'nun'},
      ],
      4: [
        // chap4: 여행
        {'original': '호텔', 'translated': 'hotel', 'romanized': 'hotel'},
        {'original': '관광', 'translated': 'tourism', 'romanized': 'gwangwang'},
        {'original': '여권', 'translated': 'passport', 'romanized': 'yeogwon'},
        {'original': '기념품', 'translated': 'souvenir', 'romanized': 'ginyeompum'},
        {'original': '약국', 'translated': 'pharmacy', 'romanized': 'yakguk'},
      ],
      5: [
        // chap5: 문화
        {'original': '축제', 'translated': 'festival', 'romanized': 'chukje'},
        {'original': '종교', 'translated': 'religion', 'romanized': 'jonggyo'},
        {'original': '명절', 'translated': 'holiday', 'romanized': 'myeongjeol'},
        {'original': '미술', 'translated': 'art', 'romanized': 'misul'},
        {'original': '예절', 'translated': 'manners', 'romanized': 'yejeol'},
      ],
      6: [
        // chap6: 인사
        {'original': '안녕하세요', 'translated': 'hello', 'romanized': 'annyeonghaseyo'},
        {'original': '안녕히 가세요', 'translated': 'goodbye', 'romanized': 'annyeonghi gaseyo'},
        {'original': '감사합니다', 'translated': 'thank you', 'romanized': 'gamsahamnida'},
        {'original': '네', 'translated': 'yes', 'romanized': 'ne'},
        {'original': '아니요', 'translated': 'no', 'romanized': 'aniyo'},
      ],
      7: [
        // chap7: 소속
        {'original': '이름', 'translated': 'name', 'romanized': 'ireum'},
        {'original': '생일', 'translated': 'birthday', 'romanized': 'saengil'},
        {'original': '국적', 'translated': 'nationality', 'romanized': 'gukjeok'},
        {'original': '주소', 'translated': 'address', 'romanized': 'juso'},
        {'original': '휴대폰 번호', 'translated': 'phone number', 'romanized': 'hyudaepon beonho'}
      ],
    });

    print('데이터 초기화가 완료되었습니다!');
  }
}
