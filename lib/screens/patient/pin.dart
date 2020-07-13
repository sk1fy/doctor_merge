import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:medical_app/models/network.dart';
import 'package:medical_app/models/users_provider.dart';
import 'package:medical_app/screens/doctor/home.dart';
import 'package:medical_app/screens/patient/home.dart';
import 'package:medical_app/utilities/constans.dart';
import 'package:provider/provider.dart';

class PinScreen extends StatefulWidget {
  final String password;
  final String phone;
  const PinScreen(
      {Key key,
      @required this.password,
      @required this.phone})
      : super(key: key);
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final _formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
          builder: (context) => Container(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Text(
                    "Для окончательной регистрации введите последние шесть цифр номера телефона из позвонившего номера телефона",
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 32,
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
                  RaisedButton(
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
                          var ud =
                              Provider.of<UsersProvider>(context, listen: false);
                          ud.setData(v.token, widget.phone, v.authId);

                          var an = AuthNetwork(v.token);
                          ud.user = await an.createUser();
                          await ud.saveToPrefs();

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => HomePagePatient()));
                        }
                      }
                    },
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}