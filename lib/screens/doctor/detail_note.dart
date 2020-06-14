import 'package:flutter/material.dart';

class DetailNoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Заметка"),),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 30.0),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      filled: true,
                      icon: Icon(Icons.person),
                      hintText: 'Иванов Иван Иванович?',
                      labelText: 'ФИО',
                      labelStyle: TextStyle(color: Colors.black),
                      fillColor: Color.fromRGBO(228, 239, 243, 1.0)),
                ),
                SizedBox(height: 30.0),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
