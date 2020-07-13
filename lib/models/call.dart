import 'package:json_annotation/json_annotation.dart';
part 'call.g.dart';

@JsonSerializable()
class Call {
  String address;
  DateTime datetime;

  Call({this.datetime, this.address});

  factory Call.rand() {
    return Call(
        datetime: DateTime.now(),
        address: "ул.Байкальская 9",
    );
  }

  factory Call.fromJson(Map<String, dynamic> data) => _$CallFromJson(data);

  Map<String, dynamic> toJson() => _$CallToJson(this);
}
