import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_app/models/users_provider.dart';
import 'package:medical_app/screens/patient/call_doctor.dart';
import 'package:medical_app/screens/patient/home_pages/about.dart';
import 'package:medical_app/screens/patient/home_pages/doctors.dart';
import 'package:medical_app/screens/patient/home_pages/orders.dart';
import 'package:medical_app/screens/patient/home_pages/profile.dart';
import 'package:medical_app/screens/patient/home_pages/stocks.dart';
import 'package:medical_app/screens/patient/login.dart';
import 'package:medical_app/utilities/constans.dart';
import 'package:medical_app/utilities/medics.dart';
import 'package:provider/provider.dart';

class HomePagePatient extends StatefulWidget {
  const HomePagePatient({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePagePatientState();
}

class _HomePagePatientState extends State<HomePagePatient> {
  final medics =  MedicList.docSpeciality; 
  int currentTabIndex = 0;

  String title = "Title";
  String helper = "helper";

  Widget _buildFloatingActionButton() {
    return Consumer<UsersProvider>(
      builder: (_, users, child) => FloatingActionButton(
        onPressed: () => Constants.prefs.getString("user") != null
            ? showModalBottomSheet(
                context: context, builder: (ctx) => _buildBottomSheet(ctx))
            : Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => LoginPatientScreen())),
        child: Image.asset(
          "assets/images/phone.png",
          width: 30,
          height: 30,
        ),
        backgroundColor: Color.fromRGBO(33, 153, 252, 1.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      StocksPage(),
      DoctorPage(),
      OrderPage(),
      AboutPage(),
      ProfilePage(),
    ];
    final _kBottmonNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.view_agenda), title: Text('Акции')),
      BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Врачи')),
      BottomNavigationBarItem(
          icon: Icon(Icons.calendar_view_day), title: Text('Заказы')),
      BottomNavigationBarItem(icon: Icon(Icons.group), title: Text('О нас')),
      BottomNavigationBarItem(
          icon: Icon(Icons.person_outline), title: Text('Профиль')),
    ];
    assert(_kTabPages.length == _kBottmonNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      items: _kBottmonNavBarItems,
      currentIndex: currentTabIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color.fromRGBO(33, 153, 252, 1.0),
      onTap: (int index) {
        setState(() {
          currentTabIndex = index;
        });
      },
    );
    return SafeArea(
      child: Consumer<UsersProvider>(
        builder: (_, users, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: Image.asset("assets/images/logo_med.png"),
            title: Text([
              "Акции",
              "Врачи",
              "Заказы",
              "О нас",
              "Профиль"
            ][currentTabIndex]),
            actions: <Widget>[
              if (currentTabIndex == 4 && users.authToken != null)
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () async {
                    users.authToken = null;
                    users.phone = null;
                    await Provider.of<UsersProvider>(context, listen: false)
                        .clear();
                    await Constants.prefs.remove("user");
                    // Navigator.pushReplacementNamed(context, 'choice');
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                ),
            ],
          ),
          floatingActionButton: _buildFloatingActionButton(),
          body: _kTabPages[currentTabIndex],
          bottomNavigationBar: bottomNavBar,
        ),
      ),
    );
  }

  Container _buildBottomSheet(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                  child: ListTile(
                      title: Text(
                    'Вызвать врача',
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
                ),
                Divider(
                  height: 15,
                  // color: Colors.white,
                  thickness: 2,
                  indent: 70,
                  endIndent: 20,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: medics.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: RaisedButton(
                    child: Text(medics[index],
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                    color: Color.fromRGBO(33, 153, 252, 1.0),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => CallDoctorScreen(
                                  title: medics[index])));
                    },
                    padding: EdgeInsets.all(15.0),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
