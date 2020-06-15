import 'package:json_annotation/json_annotation.dart';
part 'call.g.dart';

@JsonSerializable()
class Call {
  String address, comment;
  DateTime date;
  List<DateTime> connectedCalls;

  Call({this.date, this.address, this.comment, this.connectedCalls});

  factory Call.rand() {
    return Call(
        date: DateTime.now(),
        address: "ул.Байкальская 9",
        comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    );
  }

  factory Call.fromJson(Map<String, dynamic> data) => _$CallFromJson(data);

  Map<String, dynamic> toJson() => _$CallToJson(this);
}
