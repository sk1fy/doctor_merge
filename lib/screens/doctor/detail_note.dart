import 'package:flutter/material.dart';

class DetailNoteScreen extends StatefulWidget {
  @override
  _DetailNoteScreenState createState() => _DetailNoteScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _DetailNoteScreenState extends State<DetailNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Заметка"),
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
                    decoration: InputDecoration(
                      filled: true,
                      hintText: '',
                      labelText: 'Название',
                      labelStyle: TextStyle(color: Colors.black),
                      fillColor: Color.fromRGBO(228, 239, 243, 1.0),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Введите Название';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      // _name = value;
                    },
                  ),
                  SizedBox(height: 30.0),
                  TextFormField(
                    maxLines: 10,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: 'Описание:',
                      hintText: '...',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (text) => setState(() {}),
                  ),
                  SizedBox(height: 30.0),
                  RaisedButton(
                    child: Text(
                      'Сохранить',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }

                      _formKey.currentState.save();
                      //Send to API
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
