import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:medical_app/models/doctor.dart';
import 'package:medical_app/models/order.dart';
import 'package:medical_app/models/user.dart';
import 'package:medical_app/models/users_provider.dart';
import 'package:provider/provider.dart';

const baseUrlApi = "http://medic.bw2api.ru/api/v1";
// const baseUrlImage = "http://vp.bw2api.ru/";

// final getImageUrl = (String path) => path != null ? "$baseUrlImage$path" : "";

class EnterPinStatus {
  String error;
  String token, authId;

  EnterPinStatus(int code, String body) {
    error = [
      null,
      "Превышенно количество попыток входа",
      "Неверный пин код"
    ][{200: 0, 403: 1, 401: 2}[code]];
    if (code == 200) {
      var json = jsonDecode(body);
      token = json["token"];
      authId = json["data"]["auth_id"];
    }
  }
}

class EnterPasswordStatus {
  final User user;
  final Doctor doctor;
  final String token;
  final String authId;

  EnterPasswordStatus(this.user, this.doctor, this.token, this.authId);
}

class Network {
  static Map<String, String> get headers =>
      {"Content-Type": "application/json"};
  static Future<bool> enterPhone(String phone) async {
    var ans = await http.post("$baseUrlApi/enter/phone",
        body: '{"phone":"$phone"}', headers: headers);
    return ans.statusCode == 200 || ans.statusCode == 409;
  }

  static Future<EnterPinStatus> enterPin(
      String pin, String phone, String password) async {
    var ans = await http.post("$baseUrlApi/enter/pin",
        body: jsonEncode({"phone": phone, "pin": pin, "password": password}),
        headers: headers);
    return EnterPinStatus(ans.statusCode, ans.body);
  }

  static Future<EnterPasswordStatus> enterPassword(
      String phone, String password) async {
    var ans = await http.post("$baseUrlApi/enter/password",
        body: jsonEncode({"phone": phone, "password": password}),
        headers: headers);
    if (ans.statusCode == 200) {
      var json = jsonDecode(ans.body);
      return EnterPasswordStatus(
          json["data"]["user"] != null
              ? User.fromJson(json["data"]["user"])
              : null,
          json["data"]["doctor"] != null
              ? Doctor.fromJson(json["data"]["doctor"])
              : null,
          json["token"],
          json["data"]["authId"]);
    }
    return null;
  }
}

class AuthNetwork extends Network {
  final String token;

  Map<String, String> get headers =>
      {...Network.headers, "Authorization": "Bearer $token"};
  // must be call every time on request because token may be change
  Dio get _dio => Dio(BaseOptions(baseUrl: baseUrlApi, headers: headers));
  AuthNetwork(this.token);

  AuthNetwork.of(context)
      : token = Provider.of<UsersProvider>(context, listen: false).authToken;

  Future<String> refresh() async {
    try {
      var ans = await _dio.get("/enter/refresh");

      if (ans.statusCode == 200) return ans.data["token"];
      return null;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<User> createUser() async {
    var ans =
        await http.post("$baseUrlApi/crud/user", headers: headers, body: "{}");
    if (ans.statusCode != 200) throw Exception(ans.body);
    return User.fromJson(jsonDecode(ans.body));
  }

  // Future<FormData> _prepUserData(User user) async {
  //   print(user.toJson());
  //   return FormData.fromMap({
  //     ...Map.fromEntries(
  //         user.toJson().entries.where((e) => !e.key.startsWith("user"))),
  //     "user": user?.id ?? "",
  //   });
  // }

  Future updateUser(User user) async {
    // final fd = await _prepUserData(user);
    final ans = await _dio.patch("/crud/user", data: user.toJson());
    if (ans.statusCode != 200) throw Exception(ans.data);
  }

  Future<Doctor> createDoctor() async {
    final ans = await _dio.post("/crud/doctor");
    if (ans.statusCode != 200) throw Exception(ans.data);
    return Doctor.fromJson(ans.data);
  }

  // Future<FormData> _prepDoctorData(Doctor doctor) async {
  //   print(doctor.toJson());
  //   return FormData.fromMap({
  //     ...Map.fromEntries(
  //         doctor.toJson().entries.where((e) => !e.key.startsWith("doctor"))),
  //     "doctor": doctor?.id ?? "",
  //   });
  // }

  Future updateDoctor(Doctor doctor) async {
    // final fd = await _prepDoctorData(doctor);
    final ans = await _dio.patch("/crud/doctor", data: doctor.toJson());
    if (ans.statusCode != 200) throw Exception(ans.data);
  }

  Future createOrder(String client, String date, String medic, String specialization, String address, String comments, String status) async {
    var ans = await _dio.post("/crud/order", data: {
      "client": client,
      "date": date,
      "medic": medic,
      "specialization": specialization, 
      "address": address,
      "clientComment": comments,
      "status": status
    });
    if (ans.statusCode != 200) throw Exception(ans.data);
  }

    Future takeOrder(String medic, String status) async {
    var ans = await _dio.patch("/crud/order", data: {
      "medic": medic,
      "status": status
    });
    if (ans.statusCode != 200) throw Exception(ans.data);
  }

  Future updateOrder(Order order) async {
    // final fd = await _prepOrderData(order);
    var ans = await _dio.patch("/crud/order", data: order.toJson());
    if (ans.statusCode != 200) throw Exception(ans.data);
  }
}
