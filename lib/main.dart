import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lanny_program/Firebase/FirebaseAuth.dart';
import 'package:lanny_program/screens/login_screen.dart';
import 'package:lanny_program/screens/signup_screen.dart';
import 'package:lanny_program/screens/main_navigation_screen.dart'; // Assuming this is the file for MainNavigationScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LannyProgram());
}

class LannyProgram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        '/signup': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
        '/main': (context) => MainNavigationScreen(),
      },
    );
  }
}
