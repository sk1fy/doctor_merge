// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Call _$CallFromJson(Map<String, dynamic> json) {
  return Call(
    datetime: json['datetime'] == null
        ? null
        : DateTime.parse(json['datetime'] as String),
  );
}

Map<String, dynamic> _$CallToJson(Call instance) => <String, dynamic>{
      'datetime': instance.datetime?.toIso8601String(),
    };
