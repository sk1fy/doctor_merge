// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    client: json['client'] == null
        ? null
        : User.fromJson(json['client'] as Map<String, dynamic>),
    medic: json['medic'] == null
        ? null
        : Doctor.fromJson(json['medic'] as Map<String, dynamic>),
    status: json['status'] as String,
    address: json['address'] as String,
    userComment: json['userComment'] as String,
    doctorComment: json['doctorComment'] as String,
    id: json['_id'] as String,
    date: json['date'] as String,
    // date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  )
    ..chat = (json['chat'] as List)
        ?.map((e) =>
            e == null ? null : ChatMessage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..connectedCalls = (json['connectedCalls'] as List)
        ?.map(
            (e) => e == null ? null : Call.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'client': instance.client?.toJson(),
      'medic': instance.medic?.toJson(),
      'status': instance.status,
      'address': instance.address,
      'userComment': instance.userComment,
      'doctorComment': instance.doctorComment,
      'date': instance.date,
      'chat': instance.chat?.map((e) => e?.toJson())?.toList(),
      'connectedCalls': instance.connectedCalls?.map((e) => e?.toJson())?.toList(),
      '_id': instance.id,
    };
