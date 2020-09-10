import 'package:json_annotation/json_annotation.dart';
part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage {
  String date;
  String text;
  bool isUser;

  ChatMessage(this.date, this.text, this.isUser);

  factory ChatMessage.fromJson(Map<String, dynamic> data) => _$ChatMessageFromJson(data);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}