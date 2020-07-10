import 'package:flutter/material.dart';
import 'package:medical_app/models/doctor.dart';

class TestScreen extends StatelessWidget {
  final List<Doctor> doctors;
  const TestScreen({Key key, @required this.doctors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(doctors);
    return Scaffold(
      appBar: AppBar(
        title: Text('123'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}