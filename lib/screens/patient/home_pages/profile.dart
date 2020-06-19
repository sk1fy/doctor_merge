import 'package:flutter/material.dart';
import 'package:medical_app/models/data_providers.dart';
import 'package:medical_app/models/users_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

String _dropdownValue = 'Мужчина';
bool notification = false;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UsersProvider>(
      builder: (_, users, child) => SafeArea(
          child: users.authToken != null
              ? SingleChildScrollView(
                  child: Consumer<UserProvider>(
                    builder: (_, user, child) => Padding(
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
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                icon: Icon(Icons.calendar_today),
                                hintText: '01.05.1970',
                                labelText: 'Дата рождения',
                                labelStyle: TextStyle(color: Colors.black),
                                fillColor: Color.fromRGBO(228, 239, 243, 1.0),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Введите Дату рождения';
                                }
                                return null;
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
                              items: <String>[
                                'Мужчина',
                                'Женщина'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                                labelStyle: TextStyle(color: Colors.black),
                                fillColor: Color.fromRGBO(228, 239, 243, 1.0),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Пожадуйста введите правильный адрес';
                                }
                                return null;
                              },
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
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 16),
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
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Для того чтобы редатировать профиль и вызвать врача нужно авторизироваться в приложении",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20,),
                      FlatButton(
                        child: Text("Авторизируйтесь", style: TextStyle(color: Colors.blue),),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )),
    );
  }
}
