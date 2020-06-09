// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return ChatMessage(
    json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    json['text'] as String,
    json['isUser'] as bool,
  );
}

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'text': instance.text,
      'isUser': instance.isUser,
    };
