// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) {
  return Doctor(
    name: json['name'] as String,
    specialty: json['specialty'] as String,
    pushToken: json['pushToken'] as String,
    block: json['block'] as bool,
    diplomImage: json['diplomImage'] as String,
    licenseImage: json['licenseImage'] as String,
    id: json['_id'] as String,
    password: json['password'] as String,
    pin: json['pin'] as String,
  );
}

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'name': instance.name,
      'specialty': instance.specialty,
      'pushToken': instance.pushToken,
      'diplomImage': instance.diplomImage,
      'licenseImage': instance.licenseImage,
      'password': instance.password,
      'pin': instance.pin,
      'block': instance.block,
      '_id': instance.id,
    };
