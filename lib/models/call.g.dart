// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Call _$CallFromJson(Map<String, dynamic> json) {
  return Call(
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    address: json['address'] as String,
  );
}

Map<String, dynamic> _$CallToJson(Call instance) => <String, dynamic>{
      'address': instance.address,
      'date': instance.date?.toIso8601String(),
    };
