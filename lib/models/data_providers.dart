import 'package:flutter/foundation.dart';
import 'package:medical_app/models/call.dart';
import 'package:medical_app/models/chat_message.dart';
import 'package:medical_app/models/doctor.dart';
import 'package:medical_app/models/order.dart';
import 'package:medical_app/models/user.dart';

class OrderProvider extends ChangeNotifier {
  // static Order orderFromJson(json) {
  //   return Order.fromJson(json);
  // }

  User user;
  Doctor doctor;
  String status = "Активный",
      address = "ул.Байкальская 5",
      userComment = "Lorem user Comment",
      doctorComment = "Lorem doctor Comment";
  DateTime date = DateTime.now();
  List<ChatMessage> chat;
  List<Call> call;
  String id = "4321";
}
