import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:medical_app/models/network.dart';
import 'package:medical_app/screens/doctor/home.dart';
import 'package:medical_app/screens/patient/home.dart';
import 'package:medical_app/screens/patient/pin.dart';
import 'package:medical_app/utilities/contrast.dart';
import 'package:medical_app/models/users_provider.dart';
import 'package:provider/provider.dart';

class LoginPatientScreen extends StatefulWidget {
  @override
  _LoginPatientScreenState createState() => _LoginPatientScreenState();
}

class _LoginPatientScreenState extends State<LoginPatientScreen> {
  var phoneController = MaskedTextController(mask: "+7 (000) 000 00 00");
  var passwordController = TextEditingController();
  bool isPhoneValid = true;
  bool hasPassword = false;
  bool isPasswordShort = false;
  bool _rememberMe = false;
  final _formKey = GlobalKey<FormState>();

  Widget _buildPhone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 20.0,
            ),
            validator: (val) =>
                val.length != 18 ? "Введите номер телефона" : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              hintText: 'Введите ваш телефон',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 20.0,
            ),
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp("[\\w\\d_]"))
            ],
            validator: MultiValidator([
              RequiredValidator(errorText: "Введите пароль"),
              MinLengthValidator(6,
                  errorText: "Пароль должен быть длинее 6 символов")
            ]),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Введите пароль',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: () => register(context)
          // Navigator.of(context)
          //     .pushReplacement(MaterialPageRoute(builder: (ctx) => PinScreen()))
        ,
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Зарегистрироваться?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      alignment: Alignment.center,
      height: 60.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.blue,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Я принимаю условия',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => login(context),
        // {
        //   Navigator.of(context).pushReplacement(
        //       MaterialPageRoute(builder: (ctx) => HomePagePatient()));
        // },
        padding: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        color: Color.fromRGBO(104, 169, 196, 1.0),
        child: Text(
          'Войти',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.w300,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 90.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/logo_med.png"),
                        SizedBox(height: 10.0),
                        _buildPhone(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildPasswordTF(),
                        _buildRememberMeCheckbox(),
                        _buildLoginBtn(),
                        _buildForgotPasswordBtn(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future login(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      var phone = phoneController.value.text,
          password = passwordController.value.text;
      var status = await Network.enterPassword(phone, password);
      if (status != null) {
        var ud = Provider.of<UsersProvider>(context, listen: false);
        final an = AuthNetwork(status.token);

        ud
          ..setData(status.token, phone, status.authId)
          ..user = status.user ?? await an.createUser();

        await ud.saveToPrefs();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => HomePagePatient()));
      } else {
        print("error");
        // Scaffold.of(context)
        //   ..removeCurrentSnackBar()
        //   ..showSnackBar(SnackBar(
        //     // TODO change to valid error message
        //     content: Text("Неправильное имя пользователя или пароль"),
        //   ));
      }
    }
  }

  Future register(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      var phone = phoneController.value.text,
          password = passwordController.value.text;
      if (await Network.enterPhone(phone))
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (ctx) => PinScreen(
                  password: password,
                  phone: phone,
                )));
      else
      print("error");
        // Scaffold.of(context)
        //   ..removeCurrentSnackBar()
        //   ..showSnackBar(SnackBar(
        //     content: Text("Ошибка при попытки регистрации"),
        //   ));
    }
  }
}
