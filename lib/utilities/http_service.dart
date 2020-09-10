import 'dart:convert';

import 'package:http/http.dart';
import 'package:medical_app/models/call.dart';
import 'package:medical_app/models/chat_message.dart';
import 'package:medical_app/models/doctor.dart';
import 'package:medical_app/models/order.dart';

class HttpService {
  static final String urlApi = "https://medic.bw2api.ru/api/v1";

  Future<List<Order>> getOrders(String query) async {
    Response res =
        await get(urlApi + '/crud/order?_sort=date&status=New' + query);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Order> orders = body
          .map(
            (dynamic item) => Order.fromJson(item),
          )
          .toList();

      return orders;
    } else {
      throw 'Cant get orders.';
    }
  }

  Future<List<Order>> getOrderList(
      String id, String status, String type) async {
    Response res = await get(urlApi +
        '/crud/order?_sort=date' +
        '&$type=' +
        id +
        '&status=' +
        status);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Order> orders = body
          .map(
            (dynamic item) => Order.fromJson(item),
          )
          .toList();

      return orders;
    } else {
      throw 'Cant get orders.';
    }
  }

  Future<List<Doctor>> getDoctors() async {
    Response res = await get(urlApi + '/crud/doctor');

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Doctor> doctors = body
          .map(
            (dynamic item) => Doctor.fromJson(item),
          )
          .toList();

      return doctors;
    } else {
      throw 'Cant get doctors';
    }
  }

  Future<List<Order>> getChat(String id) async {
    Response res = await get(urlApi + '/crud/order' + '?_id=$id');

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Order> orders = body
          .map(
            (dynamic item) => Order.fromJson(item),
          )
          .toList();

      return orders;
    } else {
      throw 'Cant get chat';
    }
  }

  Future<List<Doctor>> getDoctorToCall(String query) async {
    Response res = await get(urlApi + '/crud/doctor' + query);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Doctor> doctors = body
          .map(
            (dynamic item) => Doctor.fromJson(item),
          )
          .toList();

      return doctors;
    } else {
      throw 'Cant get doctors';
    }
  }

  Future<List<Call>> getCalls(String order) async {
    Response res = await get(urlApi + '/crud/connected_call?_sort=datetime&order=$order');

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Call> call = body
          .map(
            (dynamic item) => Call.fromJson(item),
          )
          .toList();

      return call;
    } else {
      throw 'Cant get call.';
    }
  }
}
