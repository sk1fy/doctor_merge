import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String name, gender, pushToken, address, password, pin;
  DateTime dateBirthday;

  @JsonKey(name: "_id")
  final String id;

  User(
      {this.name,
      this.gender,
      this.pushToken,
      this.address,
      this.dateBirthday,
      this.id,
      this.password,
      this.pin
    });

  factory User.rand() {
    return User(
      name: "Иванов Андрей Петрович",
      gender: "Мужчина",
      pushToken: "03df25c845d460bcdad7802d2vf6fc1dfde97283bf75cc993eb6dca835ea2e2f",
      address: "ул.Байкальская 3",
      id: "123123",
      dateBirthday: DateTime.now()
    );}

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
