import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String note;
  @HiveField(3)
  final DateTime createdAt;

  Note({this.title, this.note = '', createdAt})
      : this.createdAt = createdAt ?? DateTime.now();
}