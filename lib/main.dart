import 'package:flutter/material.dart';
import 'package:medical_app/my_main.dart';
import 'package:medical_app/utilities/constans.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}
