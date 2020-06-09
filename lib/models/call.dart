import 'package:json_annotation/json_annotation.dart';
part 'call.g.dart';

@JsonSerializable()
class Call {
  String address;
  DateTime date;

  Call({this.date, this.address});

  factory Call.fromJson(Map<String, dynamic> data) => _$CallFromJson(data);

  Map<String, dynamic> toJson() => _$CallToJson(this);
}
