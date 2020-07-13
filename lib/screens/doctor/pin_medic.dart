import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:medical_app/models/network.dart';
import 'package:medical_app/models/users_provider.dart';
import 'package:medical_app/screens/doctor/home.dart';
import 'package:medical_app/utilities/medics.dart';
import 'package:provider/provider.dart';

class PinMedicScreen extends StatefulWidget {
  final String password;
  final String phone;
  const PinMedicScreen({Key key, @required this.password, @required this.phone})
      : super(key: key);
  @override
  _PinMedicScreenState createState() => _PinMedicScreenState();
}

class _PinMedicScreenState extends State<PinMedicScreen> {
  final _formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  final fioController = TextEditingController();
  final medics = MedicList.docSpeciality;
  String _dropdownValue = 'Педиатр';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
      builder: (context) => Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: fioController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      filled: true,
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
                    decoration: InputDecoration(),
                    items: medics.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "Для окончательной регистрации введите последние шесть цифр номера телефона из позвонившего номера телефона",
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 12,
                  ),
                  TextFormField(
                    controller: pinController,
                    obscureText: true,
                    decoration:
                        InputDecoration(labelText: "Код для регистрации"),
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 6,
                    validator: MultiValidator([
                      MinLengthValidator(6,
                          errorText: "Введите последние 6 цифр")
                    ]),
                  ),
                  fioController == null || _dropdownValue == null
                      ? Container()
                      : RaisedButton(
                          child: Text("Зарегистрироватся"),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              var pin = pinController.value.text;
                              var v = await Network.enterPin(
                                  pin, widget.phone, widget.password);
                              if (v.error != null) {
                                Scaffold.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(SnackBar(
                                    content: Text(v.error),
                                  ));
                                return;
                              } else {
                                var ud = Provider.of<UsersProvider>(context,
                                    listen: false);
                                ud.setData(v.token, widget.phone, v.authId);

                                var an = AuthNetwork(v.token);
                                ud.doctor = await an.createDoctor();
                                await ud.saveToPrefs();
                                await AuthNetwork.of(context)
                                    .updateDoctor(ud.doctor
                                      ..name = fioController.value.text
                                      ..specialty = _dropdownValue);

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => HomePageDoctor()));
                              }
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
