import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_basics/pages/homepage.dart';
import 'package:firebase_basics/pages/loginpage.dart';
import 'package:firebase_basics/pages/signup.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/landingpage': (context) => MyApp(),
        '/signup': (context) => signUp(),
        '/homepage': (context) => HomePage()
      },
    );
  }
}
