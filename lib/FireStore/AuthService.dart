import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:lanny_program/data/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  ///'visitCounts' 'continuous' 필드 업데이트 함수
  Future<void> updateContinuousIfYesterday(String email) async {
    try {
      // Firestore에서 이메일로 사용자 문서 검색
      QuerySnapshot snapshot = await _firestore
          .collection('user')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var doc = snapshot.docs.first;
        String docId = doc.id;
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;

        // 'visitCounts' 값 증가
        int currentVisitCounts = int.parse(userData['visitCounts'] ?? '0');
        int updatedVisitCounts = currentVisitCounts + 1;

        // Firestore에 'visitCounts' 업데이트
        await _firestore.collection('user').doc(docId).update({
          'visitCounts': updatedVisitCounts.toString(),
        });

        print("Visit counts updated to: $updatedVisitCounts");

        // 'continuous' 증가 로직 (하루에 한 번만)
        if (userData.containsKey('lastContinuousUpdate')) {
          // 마지막 업데이트 날짜 확인
          String lastUpdate = userData['lastContinuousUpdate'] ?? '';
          String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

          if (lastUpdate != today) {
            // 날짜가 다르면 'continuous' 값 증가
            int currentContinuous = int.parse(userData['continuous']);
            int updatedContinuous = currentContinuous + 1;

            await _firestore.collection('user').doc(docId).update({
              'continuous': updatedContinuous.toString(),
              'lastContinuousUpdate': today, // 오늘 날짜로 갱신
            });

            print("Continuous streak updated to: $updatedContinuous");
          } else {
            print("Continuous streak already updated today. No changes made.");
          }
        } else {
          // 'lastContinuousUpdate'가 없으면 초기화
          int currentContinuous = int.parse(userData['continuous']);
          int updatedContinuous = currentContinuous + 1;

          await _firestore.collection('user').doc(docId).update({
            'continuous': updatedContinuous.toString(),
            'lastContinuousUpdate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
          });

          print("Continuous streak initialized and updated to: $updatedContinuous");
        }
      } else {
        print("No user found with email: $email");
      }
    } catch (e) {
      print("Error updating visitCounts and continuous fields: $e");
    }
  }



  /// 회원가입 함수
  Future<void> signUpAndAddToFirestore({
    required String email,
    required String password,
    required String id,
    required String continuous,
  }) async {
    try {
      // Firebase Authentication에 사용자 생성
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // UID 가져오기
      String uid = userCredential.user!.uid;

      // Firestore에 UID를 document ID로 사용하여 데이터 저장
      await _firestore.collection('user').doc(uid).set({
        'ID': id,
        'PassWord': password,
        'UID': uid,
        'continuous': continuous,
        'email': email,
        'visitContinuousflag' : "true",
      });

      print("User registered and added to Firestore successfully.");
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.message}");
      throw Exception(e.message); // 에러를 상위로 전달
    } catch (e) {
      print("General Error: $e");
      throw Exception("An error occurred.");
    }
  }

  /// UID로 Firestore 사용자 조회
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc =
      await _firestore.collection('user').doc(uid).get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        print("No user found with UID: $uid");
        return null;
      }
    } catch (e) {
      print("Error fetching user: $e");
      return null;
    }
  }

  /// 로그인 함수
  Future<UserCredential?> loginWithEmailAndPassword(String email, String password) async {
    try {
      // Firebase Authentication으로 이메일과 비밀번호 확인
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 로그인 성공 시 UserCredential 반환
      print("User logged in successfully: ${userCredential.user?.uid}");
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.message}");
      return null;
    } catch (e) {
      print("General Error: $e");
      return null;
    }
  }

  /// Firestore에서 이메일로 사용자 데이터 가져오기
  Future<UserData?> getUserDataByEmail(String email) async {
    try {
      // Firestore에서 이메일로 UID 검색
      QuerySnapshot snapshot = await _firestore
          .collection('user')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // 첫 번째 문서의 데이터를 가져옴
        var doc = snapshot.docs.first;

        // UserData 객체 생성
        return UserData.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        print("No user found with email: $email");
        return null;
      }
    } catch (e) {
      print("Error fetching user by email: $e");
      return null;
    }
  }

}
