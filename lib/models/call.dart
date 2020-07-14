import 'package:json_annotation/json_annotation.dart';
part 'call.g.dart';

@JsonSerializable()
class Call {
  DateTime datetime;

  Call({this.datetime});

  factory Call.rand() {
    return Call(
        datetime: DateTime.now(),
    );
  }

  factory Call.fromJson(Map<String, dynamic> data) => _$CallFromJson(data);

  Map<String, dynamic> toJson() => _$CallToJson(this);
}
