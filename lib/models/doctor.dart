import 'package:json_annotation/json_annotation.dart';
part 'doctor.g.dart';

@JsonSerializable()
class Doctor {
  String name, specialty, pushToken, diplomImage, licenseImage;
  bool block;

  @JsonKey(name: "_id")
  final String id;

  Doctor(
      {this.name,
      this.specialty,
      this.pushToken,
      this.block,
      this.diplomImage,
      this.licenseImage,
      this.id});

  factory Doctor.rand() {
    return Doctor(
      name: "Иванов Андрей Петрович",
      specialty: "Педиатр",
      pushToken: "03df25c845d460bcdad7802d2vf6fc1dfde97283bf75cc993eb6dca835ea2e2f",
      diplomImage: "https://raw.githubusercontent.com/flutter/website/master/examples/layout/lakes/step5/images/lake.jpg",
      licenseImage: "https://raw.githubusercontent.com/flutter/website/master/examples/layout/lakes/step5/images/lake.jpg",
      id: "123125",
    );
  }

  factory Doctor.fromJson(Map<String, dynamic> data) => _$DoctorFromJson(data);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
