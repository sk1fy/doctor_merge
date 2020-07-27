import 'package:flutter/material.dart';
import 'package:medical_app/models/data_providers.dart';
import 'package:medical_app/models/network.dart';
import 'package:medical_app/models/users_provider.dart';
import 'package:medical_app/utilities/medics.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

final TextEditingController _fioController = TextEditingController();
final medics = MedicList.docSpeciality;
String _dropdownValue = 'Педиатр';
bool notification = false;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Consumer2<UsersProvider, DoctorProvider>(
        builder: (_, users, doctor, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 30.0),
                TextFormField(
                  controller: _fioController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.person),
                    hintText: 'Иванов Иван Иванович',
                    labelText: users.doctor.name ?? 'ФИО',
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
                  items: medics.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 30.0),
                // Row(
                //   children: <Widget>[
                //     Expanded(
                //       flex: 1,
                //       child: FlatButton(
                //           onPressed: () => print("Diplom"),
                //           child: Column(
                //             children: <Widget>[
                //               Icon(
                //                 Icons.insert_photo,
                //                 size: 64.0,
                //                 color: Colors.black87,
                //               ),
                //               const Text("Диплом",
                //                   style: TextStyle(color: Colors.black87))
                //             ],
                //           )),
                //     ),
                //     Expanded(
                //       flex: 1,
                //       child: FlatButton(
                //           onPressed: () => print("Lisence"),
                //           child: Column(
                //             children: <Widget>[
                //               Icon(
                //                 Icons.insert_photo,
                //                 size: 64.0,
                //                 color: Colors.black87,
                //               ),
                //               const Text(
                //                 "Лицензия",
                //                 style: TextStyle(color: Colors.black87),
                //               )
                //             ],
                //           )),
                //     )
                //   ],
                // ),
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
                SizedBox(
                  height: 50,
                  child: RaisedButton(
                    child: Text(
                      'Сохранить',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        saveDoctor(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future saveDoctor(context) async {
    final name = _fioController.text;
    final specialization = _dropdownValue;
    
    final users = Provider.of<UsersProvider>(context, listen: false);
    final pushToken = null;
    // notification == false ? null : users.doctor.pushToken;
    try {
      await AuthNetwork.of(context).updateDoctor(users.doctor
        ..name = name
        ..specialty = specialization
        ..pushToken = pushToken);
      await users.saveToPrefs();
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text("Сохраненно"),
        ));
    } catch (err) {
      print(err);
    }
  }
}
