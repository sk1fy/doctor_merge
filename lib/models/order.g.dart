// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    doctor: json['doctor'] == null
        ? null
        : Doctor.fromJson(json['doctor'] as Map<String, dynamic>),
    status: json['status'] as String,
    address: json['address'] as String,
    userComment: json['userComment'] as String,
    doctorComment: json['doctorComment'] as String,
    id: json['_id'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  )
    ..chat = (json['chat'] as List)
        ?.map((e) =>
            e == null ? null : ChatMessage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..call = (json['call'] as List)
        ?.map(
            (e) => e == null ? null : Call.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'user': instance.user?.toJson(),
      'doctor': instance.doctor?.toJson(),
      'status': instance.status,
      'address': instance.address,
      'userComment': instance.userComment,
      'doctorComment': instance.doctorComment,
      'date': instance.date?.toIso8601String(),
      'chat': instance.chat?.map((e) => e?.toJson())?.toList(),
      'call': instance.call?.map((e) => e?.toJson())?.toList(),
      '_id': instance.id,
    };