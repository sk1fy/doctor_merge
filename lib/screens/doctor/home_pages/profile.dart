import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

String _dropdownValue = 'Педиатр';
bool notification = false;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            DropdownButtonFormField<String>(
              // Must be one of items.value.
              value: _dropdownValue,
              onChanged: (String newValue) {
                setState(() {
                  _dropdownValue = newValue;
                });
              },
              decoration: InputDecoration(
                icon: Icon(Icons.supervised_user_circle),
              ),
              items: <String>['Педиатр', 'Терапевт']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 30.0),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: FlatButton(
                      onPressed: () => print("Diplom"),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.insert_photo, size:  64.0, color: Colors.black87,),
                          const Text("Диплом", style: TextStyle(color: Colors.black87))
                        ],
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                      onPressed: () => print("Lisence"),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.insert_photo, size:  64.0, color: Colors.black87,),
                          const Text("Лицензия", style: TextStyle(color: Colors.black87),)
                        ],
                      )),
                )
              ],
            ),
            SizedBox(height: 30.0),
            SwitchListTile(
              onChanged: (_) {
                setState(() {
                  notification = _;
                });
              },
              value: notification,
              title: Text("Получать рекламные push"),
            ),
          ],
        ),
      ),
    );
  }
}
