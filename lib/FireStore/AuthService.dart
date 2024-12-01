import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:lanny_program/data/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  /// 'continuous' 필드 업데이트 함수
  Future<void> updateContinuousIfYesterday(String email) async {
    try {
      // 현재 날짜와 어제 날짜 계산
      DateTime now = DateTime.now();
      DateTime yesterday = now.subtract(Duration(days: 1));
      String yesterdayFormatted = DateFormat('yyyy-MM-dd').format(yesterday);

      // Firebase Authentication에서 이메일로 사용자 검색
      User? user = (await FirebaseAuth.instance.fetchSignInMethodsForEmail(email))
          .isNotEmpty
          ? FirebaseAuth.instance.currentUser
          : null;

      if (user != null) {
        // Authentication의 '마지막 로그인 날짜' 확인
        DateTime? lastLoginTime = user.metadata.lastSignInTime;

        if (lastLoginTime != null) {
          String lastLoginFormatted = DateFormat('yyyy-MM-dd').format(lastLoginTime);

          // 어제 로그인했는지 확인
          if (lastLoginFormatted == yesterdayFormatted) {
            // Firestore에서 이메일로 사용자 문서 검색
            QuerySnapshot snapshot = await _firestore
                .collection('user')
                .where('email', isEqualTo: email)
                .get();

            if (snapshot.docs.isNotEmpty) {
              var doc = snapshot.docs.first;
              String docId = doc.id;
              Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;

              // 'continuous' 값 증가
              int currentContinuous = int.parse(userData['continuous']);
              int updatedContinuous = currentContinuous + 1;

              // Firestore에 업데이트
              await _firestore.collection('user').doc(docId).update({
                'continuous': updatedContinuous.toString(),
              });

              print("Continuous streak updated to: $updatedContinuous");
            } else {
              print("No user found with email: $email");
            }
          } else {
            print("User did not log in yesterday. No changes made.");
          }
        } else {
          print("Last sign-in time not available for the user.");
        }
      } else {
        print("No user found in Authentication with email: $email");
      }
    } catch (e) {
      print("Error updating continuous field: $e");
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
