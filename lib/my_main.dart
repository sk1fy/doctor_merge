import 'package:flutter/material.dart';
import 'package:medical_app/choice.dart';
import 'package:medical_app/models/users_provider.dart';
import 'package:medical_app/screens/doctor/home.dart';
import 'package:medical_app/screens/doctor/home_pages/orders.dart';
import 'package:medical_app/screens/doctor/login.dart';
import 'package:medical_app/screens/patient/home.dart';
import 'package:medical_app/screens/patient/login.dart';
import 'package:medical_app/utilities/constans.dart';
import 'package:medical_app/utilities/simple_fb_notifications.dart';
import 'package:provider/provider.dart';
import 'models/data_providers.dart';

const Color mainColor = Color.fromRGBO(33, 153, 252, 1.0);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NotificationWrapper(
      topic: 'medical_app',
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<OrderProvider>(create: (_) => OrderProvider()),
          ChangeNotifierProvider<DoctorProvider>(
              create: (_) => DoctorProvider()),
          ChangeNotifierProvider<StockProvider>(create: (_) => StockProvider()),
          ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
          ChangeNotifierProvider<UsersProvider>(create: (_) => UsersProvider()),
        ],
        child: Constants.prefs.getBool("type") != null
            ? MaterialApp(
                title: 'Medical App',
                theme: ThemeData(
                    primaryColor: Colors.white,
                    primarySwatch: Colors.blue,
                    primaryIconTheme: Theme.of(context)
                        .primaryIconTheme
                        .copyWith(color: Colors.black),
                    primaryTextTheme:
                        TextTheme(headline6: TextStyle(color: Colors.black))),
                home: SplashScreen(),
                routes: {
                  'doctorLogin': (context) => LoginDoctorScreen(),
                  'doctorOrders': (context) => OrderPage(),
                  'userLogin': (context) => LoginPatientScreen(),
                  'choice': (context) => ChoiceScreen(),
                  'patientHome': (context) => HomePagePatient(),
                },
                debugShowCheckedModeBanner: false,
              )
            : MaterialApp(
                title: 'Medical App',
                theme: ThemeData(
                    primaryColor: Colors.white,
                    primarySwatch: Colors.blue,
                    primaryIconTheme: Theme.of(context)
                        .primaryIconTheme
                        .copyWith(color: Colors.black),
                    primaryTextTheme:
                        TextTheme(headline6: TextStyle(color: Colors.black))),
                home: ChoiceScreen(),
                routes: {
                  'doctorLogin': (context) => LoginDoctorScreen(),
                  'userLogin': (context) => LoginPatientScreen(),
                  'choice': (context) => ChoiceScreen(),
                },
                debugShowCheckedModeBanner: false,
              ),
      ),
    );
  }
}


class SplashScreen extends StatelessWidget {
  void gotoLoginDoctorScreen(context) {
    Future.microtask(() => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => LoginDoctorScreen())));
  }
  void gotoLoginPatientScreen(context) {
    Future.microtask(() => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => LoginPatientScreen())));
  }

  void gotoHomeDoctorScreen(context) {
    Future.microtask(() => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomePageDoctor())));
  }

  void gotoHomePatientScreen(context) {
    Future.microtask(() => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomePagePatient())));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<UsersProvider>(context, listen: false).loadFromPrefs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          //todo change to item 1
          if (snapshot.data == null)
            Constants.prefs.getBool("type") == true 
              ? gotoLoginDoctorScreen(context)
              : gotoHomePatientScreen(context);
          else
            Constants.prefs.getBool("type") == true
              ? gotoHomeDoctorScreen(context)
              : gotoHomePatientScreen(context);
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
