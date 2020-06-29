import 'package:json_annotation/json_annotation.dart';
import 'package:medical_app/models/call.dart';
import 'package:medical_app/models/chat_message.dart';
import 'package:medical_app/models/doctor.dart';
import 'package:medical_app/models/user.dart';
part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  User client;
  Doctor medic;
  String status, address, userComment, doctorComment;
  String date;
  List<ChatMessage> chat;
  List<Call> connectedCalls;

  @JsonKey(name: "_id")
  final String id;

  Order(
      {this.client,
      this.medic,
      this.status,
      this.address,
      this.userComment,
      this.doctorComment,
      this.id,
      this.date,
      this.connectedCalls,
      this.chat});

  factory Order.rand() {
    return Order(
        status: "Активный",
        date: '1990-12-12',
        address: "ул.Байкальская 5",
        userComment:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        doctorComment: "Lorem ipsum dolor doctor.",
        id: "4431");
  }

  factory Order.fromJson(Map<String, dynamic> data) => _$OrderFromJson(data);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
