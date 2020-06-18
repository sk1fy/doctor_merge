import 'package:flutter/material.dart';
import 'package:medical_app/choice.dart';
import 'package:medical_app/screens/doctor/login.dart';
import 'package:medical_app/screens/patient/home.dart';
import 'package:medical_app/utilities/constans.dart';
import 'package:provider/provider.dart';
import 'models/data_providers.dart';

const Color mainColor = Color.fromRGBO(33, 153, 252, 1.0);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OrderProvider>(create: (_) => OrderProvider()),
        ChangeNotifierProvider<DoctorProvider>(create: (_) => DoctorProvider()),
        ChangeNotifierProvider<StockProvider>(create: (_) => StockProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
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
              home: Constants.prefs.getBool("type") == true
                    ? LoginDoctorScreen()
                    : HomePagePatient(),
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
            ),
    );
  }
}
