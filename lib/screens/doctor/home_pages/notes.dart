import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/models/note.dart';
import 'package:medical_app/screens/doctor/add_note.dart';
import 'package:medical_app/utilities/hive_box.dart';


class NotesDoctor extends StatefulWidget {
  @override
  _NotesDoctorState createState() => _NotesDoctorState();
}

class _NotesDoctorState extends State<NotesDoctor> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: 80.0,
            width: double.infinity,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => AddNoteScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 15),
                  const Text(
                    "Создать заметку",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )),
        Expanded(
          child: Container(
            // margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 15),
            padding: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(top: 12),
                child: ValueListenableBuilder(
                  valueListenable: Hive.box<Note>(HiveBoxes.note).listenable(),
                  builder: (context, Box<Note> box, _) {
                    if (box.values.isEmpty)
                      return Center(
                        child: Text("Список заметок пуст"),
                      );
                    return ListView.builder(
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        Note res = box.getAt(index);
                        return Dismissible(
                          background: Container(
                            color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.delete),
                                Icon(Icons.delete),
                              ],
                            ),
                          ),
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            res.delete();
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Заметка ${res.title} удалена")));
                          },
                          child: ExpansionTile(
                            leading: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.blue),
                            ),
                            title: Text(res.title == null ? '' : res.title,
                                style: TextStyle(fontSize: 16)),
                                subtitle: Text(DateFormat('dd.MM.yyyy, HH:mm', 'en_US').format(res.createdAt).toString()),
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(24.0),
                                              child: Text(res.note == null
                                                  ? ''
                                                  : res.note)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
