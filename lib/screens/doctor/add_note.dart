import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medical_app/models/note.dart';
import 'package:medical_app/utilities/hive_box.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String title;
String note;

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Новая заметка"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 30.0),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    autofocus: true,
                    initialValue: '',
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Заголовок',
                      labelStyle: TextStyle(color: Colors.black),
                      fillColor: Color.fromRGBO(228, 239, 243, 1.0),
                    ),
                    validator: (val) {
                      return val.trim().isEmpty
                          ? 'Поле не должно быть пустым'
                          : null;
                    },
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                    onSaved: (String value) {
                      // _name = value;
                    },
                  ),
                  SizedBox(height: 30.0),
                  TextFormField(
                    initialValue: '',
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Описание',
                    ),
                    onChanged: (value) {
                      setState(() {
                        note = value == null ? '' : value;
                      });
                    },
                  ),
                  SizedBox(height: 30.0),
                  RaisedButton(
                    elevation: 5.0,
                    padding: EdgeInsets.all(20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    color: Color.fromRGBO(104, 169, 196, 1.0),
                    child: Text(
                      'Создать',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onPressed: _validateAndSave,
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
    void _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      _onFormSubmit();
    } else {
      print('form is invalid');
    }
  }

  void _onFormSubmit() {
    Box<Note> contactsBox = Hive.box<Note>(HiveBoxes.note);
    contactsBox.add(Note(title: title, note: note));
    Navigator.of(context).pop();
  }
}
