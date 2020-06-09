import 'package:flutter/material.dart';
import 'package:medical_app/screens/login.dart';

const Color mainColor = Color.fromRGBO(33, 153, 252, 1.0);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical App',
      theme: ThemeData(
          primaryColor: Colors.white,
          primarySwatch: Colors.blue,
          primaryIconTheme:
              Theme.of(context).primaryIconTheme.copyWith(color: Colors.black),
          primaryTextTheme:
              TextTheme(headline6: TextStyle(color: Colors.black))),
      home: LoginScreen(),
    );
  }
}
