import 'package:date_text_masked/date_text_masked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:medical_app/models/data_providers.dart';
import 'package:medical_app/models/network.dart';
import 'package:medical_app/models/users_provider.dart';
import 'package:medical_app/screens/patient/login.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

var dateController = MaskedTextController(mask: "0000-00-00");
var fioController = TextEditingController();
var addressController = TextEditingController();
String _dropdownValue = 'Мужчина';
bool notification = false;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final u = Provider.of<UsersProvider>(context, listen: false);
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
                              controller: fioController,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                filled: true,
                                icon: Icon(Icons.person),
                                hintText: users.user.name,
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
                              controller: dateController,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                filled: true,
                                icon: Icon(Icons.calendar_today),
                                hintText: '1990-01-10',
                                labelText: 'Дата рождения',
                                labelStyle: TextStyle(color: Colors.black),
                                fillColor: Color.fromRGBO(228, 239, 243, 1.0),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Пожадуйста введите правильную дату';
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
                              controller: addressController,
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
                              onPressed: () => {
                                // if (_formKey.currentState.validate())
                                  {saveUser(context)}
                              },
                            ),
                            SizedBox(height: 20),
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
                      SizedBox(
                        height: 20,
                      ),
                      FlatButton(
                        child: Text(
                          "Авторизируйтесь",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => LoginPatientScreen()));
                        },
                      ),
                    ],
                  ),
                )),
    );
  }

  Future saveUser(context) async {
    var dateConvert = '2020-06-19T07:26:37.314Z';
    // dateController.text + ' ' + '00:00:00.000';
    final name = fioController.text;
    final address = (addressController.value.text);
    final gender = _dropdownValue;
    final date = DateTime.parse(dateConvert);
    final users = Provider.of<UsersProvider>(context, listen: false);
    print(name);
    print(address.toString());
    print(date);
    print(users.user.birthdate);
    print(users.user.name);
    // try {
    //   await AuthNetwork.of(context).updateUser(users.user
    //     ..name = name
    //     // ..address = addressController.value.text
    //     ..gender = gender
    //     ..birthdate = date);
    //   Scaffold.of(context)
    //     ..removeCurrentSnackBar()
    //     ..showSnackBar(SnackBar(
    //       content: Text("Сохраненно"),
    //     ));
    // } catch (err) {
    //   print(err);
    // }
  }
}
