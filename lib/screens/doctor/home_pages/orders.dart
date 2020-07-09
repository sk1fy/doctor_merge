import 'package:flutter/material.dart';
import 'package:medical_app/widgets/order_list.dart';

class CustomTabs extends StatefulWidget {
  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  final String active = "Активные";
  final String complete = "Завершенные";

  _CustomTabsState() {
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: TabBar(
              controller: _controller,
              indicatorColor: Color.fromRGBO(33, 153, 252, 1.0),
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: active,
                ),
                Tab(text: complete),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                OrderList(currentStatus: 'Active', typeUser: 'medic'),
                OrderList(currentStatus: 'Ended', typeUser: 'medic'),
              ],
              physics: NeverScrollableScrollPhysics(),
            ),
          )
        ],
      ),
    );
  }
}

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return CustomTabs();
  }
}



