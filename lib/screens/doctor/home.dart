import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_app/models/users_provider.dart';
import 'package:medical_app/screens/doctor/avalible_order.dart';
import 'package:medical_app/screens/doctor/home_pages/about.dart';
import 'package:medical_app/screens/doctor/home_pages/notes.dart';
import 'package:medical_app/screens/doctor/home_pages/orders.dart';
import 'package:medical_app/screens/doctor/home_pages/profile.dart';
import 'package:medical_app/screens/doctor/home_pages/stocks.dart';
import 'package:provider/provider.dart';

class HomePageDoctor extends StatefulWidget {
  const HomePageDoctor({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageDoctorState();
}

class _HomePageDoctorState extends State<HomePageDoctor> {
  int currentTabIndex = 0;

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => AvalibleOrderScreen())),
      child: Icon(Icons.queue),
      backgroundColor: Color.fromRGBO(33, 153, 252, 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      StocksPage(),
      NotesDoctor(),
      OrderPage(),
      AboutPage(),
      ProfilePage(),
    ];
    final _kBottmonNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.view_agenda), title: Text('Акции')),
      BottomNavigationBarItem(
          icon: Icon(Icons.receipt), title: Text('Заметки')),
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
            "Заметки",
            "Заказы",
            "О нас",
            "Профиль"
          ][currentTabIndex]),
          actions: <Widget>[
            if (currentTabIndex == 4)
              Consumer<UsersProvider>(
                builder: (_, users, child) => IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () async {
                    users.authToken = null;
                    users.phone = null;
                    await Provider.of<UsersProvider>(context, listen: false)
                        .clear();
                    // Navigator.pushReplacementNamed(context, 'doctorLogin');
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                ),
              ),
          ],
        ),
        floatingActionButton: _buildFloatingActionButton(),
        body: _kTabPages[currentTabIndex],
        bottomNavigationBar: bottomNavBar,
      ),
    );
  }
}
