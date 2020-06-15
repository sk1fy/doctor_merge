import 'package:json_annotation/json_annotation.dart';
// part 'note.g.dart';

@JsonSerializable()
class Note {
  String title, description;
  DateTime date;

  @JsonKey(name: "_id")
  final String id;
  
  Note({this.id, this.title, this.date, this.description});

  // factory Note.fromJson(Map<String, dynamic> data) => _$NoteFromJson(data);

  // Map<String, dynamic> toJson() => _$NoteToJson(this);
}