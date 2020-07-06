import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medical_app/models/note.dart';
import 'package:medical_app/my_main.dart';
import 'package:medical_app/utilities/constans.dart';
import 'package:medical_app/utilities/hive_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>(HiveBoxes.note);
  runApp(MyApp());
}
