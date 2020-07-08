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
    clientComment: json['clientComment'] as String,
    medicComment: json['medicComment'] as String,
    id: json['_id'] as String,
    date: json['date'] as String,
    specialization: json['specialization'] as String,
    connectedCalls: (json['connectedCalls'] as List)
        ?.map(
            (e) => e == null ? null : Call.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    chat: (json['chat'] as List)
        ?.map((e) =>
            e == null ? null : ChatMessage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'user': instance.user?.toJson(),
      'doctor': instance.doctor?.toJson(),
      'status': instance.status,
      'address': instance.address,
      'clientComment': instance.clientComment,
      'medicComment': instance.medicComment,
      'date': instance.date,
      'specialization': instance.specialization,
      'chat': instance.chat?.map((e) => e?.toJson())?.toList(),
      'connectedCalls':
          instance.connectedCalls?.map((e) => e?.toJson())?.toList(),
      '_id': instance.id,
    };
