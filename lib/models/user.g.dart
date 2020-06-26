// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'] as String,
    gender: json['gender'] as String,
    pushToken: json['pushToken'] as String,
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    password: json['password'] as String,
    pin: json['pin'] as String,
    birthdate: json['birthdate'] as String,
    // birthdate: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    id: json['_id'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'gender': instance.gender,
      'address': instance.address?.toJson(),
      'pushToken': instance.pushToken,
      'password': instance.password,
      'pin': instance.pin,
      'birthdate': instance.birthdate,
      // 'date': instance.birthdate?.toIso8601String(),
      '_id': instance.id,
    };
