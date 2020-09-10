// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return ChatMessage(
    // json['date'] == null
    //     ? null
    //     : DateTime.parse(json['date'] as String),
    json['date'] as String,
    json['text'] as String,
    json['isUser'] as bool,
  );
}

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      // 'date': instance.date?.toIso8601String(),
      'date': instance.date,
      'text': instance.text,
      'isUser': instance.isUser,
    };
