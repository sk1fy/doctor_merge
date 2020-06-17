import 'package:flutter/material.dart';
import 'package:medical_app/models/data_providers.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

String _dropdownValue = 'Педиатр';
bool notification = false;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<DoctorProvider>(
        builder: (_, doctor, child) => Padding(
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
                    icon: Icon(Icons.person),
                    hintText: 'Иванов Иван Иванович',
                    labelText: 'ФИО',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Color.fromRGBO(228, 239, 243, 1.0),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Введите ФИО';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    // _name = value;
                  },
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
                              Icon(
                                Icons.insert_photo,
                                size: 64.0,
                                color: Colors.black87,
                              ),
                              const Text("Диплом",
                                  style: TextStyle(color: Colors.black87))
                            ],
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                          onPressed: () => print("Lisence"),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.insert_photo,
                                size: 64.0,
                                color: Colors.black87,
                              ),
                              const Text(
                                "Лицензия",
                                style: TextStyle(color: Colors.black87),
                              )
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
                SizedBox(height: 20),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
