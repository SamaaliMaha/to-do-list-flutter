import 'package:flutter/material.dart';
import 'package:todolist_app/screens/homepage.dart';
import 'package:todolist_app/screens/login.dart';
import 'package:todolist_app/screens/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => loginpage(),
        '/signup': (context) => signup(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
