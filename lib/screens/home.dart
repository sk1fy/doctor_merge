import 'package:flutter/material.dart';
import 'package:medical_app/screens/about.dart';
import 'package:medical_app/screens/avalible_order.dart';
import 'package:medical_app/screens/notes_doctor.dart';
import 'package:medical_app/screens/orders.dart';
import 'package:medical_app/screens/profile.dart';
import 'package:medical_app/screens/stocks.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentTabIndex = 0;

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => AvalibleOrderScreen())),
      child: Icon(Icons.add),
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
      BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Заметки')),
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
            "Заметки",
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
}

