import 'package:flutter/material.dart';
import 'package:medical_app/screens/patient/call_doctor.dart';
import 'package:medical_app/screens/patient/home_pages/about.dart';
import 'package:medical_app/screens/patient/home_pages/doctors.dart';
import 'package:medical_app/screens/patient/home_pages/orders.dart';
import 'package:medical_app/screens/patient/home_pages/profile.dart';
import 'package:medical_app/screens/patient/home_pages/stocks.dart';


class HomePagePatient extends StatefulWidget {
  const HomePagePatient({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePagePatientState();
}

class _HomePagePatientState extends State<HomePagePatient> {
  int currentTabIndex = 0;

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => showModalBottomSheet(
          context: context, builder: (ctx) => _buildBottomSheet(ctx)),
      child: Image.asset(
        "assets/images/phone.png",
        width: 30,
        height: 30,
      ),
      backgroundColor: Color.fromRGBO(33, 153, 252, 1.0),
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
      BottomNavigationBarItem(icon: Icon(Icons.calendar_view_day), title: Text('Заказы')),
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
          print(index);
        });
      },
    );
    return SafeArea(
      child: Scaffold(
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
        ),
        floatingActionButton: _buildFloatingActionButton(),
        body: _kTabPages[currentTabIndex],
        bottomNavigationBar: bottomNavBar,
      ),
    );
  }

  Widget _buildSheetButton() {
    return RaisedButton(
      child: Text(
        'Педиатр',
        style: TextStyle(color: Colors.white, fontSize: 18) 
      ),
      color: Color.fromRGBO(33, 153, 252, 1.0),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => CallDoctorScreen()));
      },
      padding: EdgeInsets.all(17.0),
    );
  }

  Container _buildBottomSheet(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(15.0),
      child: ListView(
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceAround,
              spacing: 8.0,
              runSpacing: 8.0,
              children: <Widget>[
                _buildSheetButton(),
                _buildSheetButton(),
                _buildSheetButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
