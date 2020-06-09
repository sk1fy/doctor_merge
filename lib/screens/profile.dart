import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

String _dropdownValue = 'Мужчина';
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
                  fillColor: Color.fromRGBO(228, 239, 243, 1.0)),
            ),
            SizedBox(height: 30.0),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  filled: true,
                  icon: Icon(Icons.calendar_today),
                  hintText: '01.05.1970',
                  labelText: 'Дата рождения',
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
              items: <String>['Мужчина', 'Женщина']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 30.0),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  filled: true,
                  icon: Icon(Icons.room),
                  hintText: 'г.Улан-Удэ,ул.Байкальская 10',
                  labelText: 'Адрес',
                  fillColor: Color.fromRGBO(228, 239, 243, 1.0)),
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
