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
    address: json['address'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    id: json['_id'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'gender': instance.gender,
      'pushToken': instance.pushToken,
      'address': instance.address,
      'date': instance.date?.toIso8601String(),
      '_id': instance.id,
    };