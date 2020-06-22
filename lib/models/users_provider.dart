import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_app/models/doctor.dart';
import 'package:medical_app/models/network.dart';
import 'package:medical_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

class UsersProvider extends ChangeNotifier {
  User user;
  Doctor doctor;

  String authToken, phone, authId;
  bool tokenIsValid = false;

  Future clear(){
    user = null;
    doctor = null;
    phone = "";
    authToken = "";
    tokenIsValid = false;

    return saveToPrefs();
  }

  // called on new user creation
  void setData(String newToken, String newPhone, String newAuthId) {
    authToken = newToken;
    phone = newPhone;
    authId = newAuthId;
    // super.notifyListeners();
  }

  Future saveToPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", authToken);
    await prefs.setString("phone", phone);

    if(user != null)await prefs.setString("user", jsonEncode(user.toJson()));
    else await prefs.remove("user");

    if(doctor != null)await prefs.setString("doctor", jsonEncode(doctor.toJson()));
    else await prefs.remove("doctor");

    // TODO reduce updates
    super.notifyListeners();
  }
  
  Future<Tuple2<bool,bool>> loadFromPrefs() async {
    var prefs = await SharedPreferences.getInstance();

    authToken = prefs.getString("token");
    phone = prefs.getString("phone");
    final userString = prefs.getString("user");
    if (userString != null) 
      user = User.fromJson(jsonDecode(userString));
    final doctorString = prefs.getString("doctor");
    if (doctorString != null)
      doctor = Doctor.fromJson(jsonDecode(doctorString));

    super.notifyListeners();
    var newToken = await AuthNetwork(authToken).refresh();
    if (newToken == null) return Tuple2<bool,bool>(false,false);
  
    authToken = newToken;
    saveToPrefs();
    return Tuple2<bool,bool>(user != null,doctor != null);
  }
}