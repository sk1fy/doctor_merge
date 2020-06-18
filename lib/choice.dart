import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_app/screens/doctor/login.dart';
import 'package:medical_app/screens/patient/home.dart';
import 'package:medical_app/utilities/constans.dart';



class ChoiceScreen extends StatefulWidget {
  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {


  Widget _buildPatientBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Constants.prefs.setBool("type", false);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => HomePagePatient()));
        },
        padding: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        color: Color.fromRGBO(104,169,196,1.0),
        child: Text(
          'Пациент',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
    Widget _buildDoctorBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Constants.prefs.setBool("type", true);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => LoginDoctorScreen()));
        },
        padding: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        color: Color.fromRGBO(104,169,196,1.0),
        child: Text(
          'Врач',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
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
              Center(
                child: Container(
                  padding: EdgeInsets.all(26),
                  height: double.infinity,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/logo_med.png"),
                    SizedBox(height: 10.0),
                    _buildPatientBtn(),
                    _buildDoctorBtn(),
                  ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}