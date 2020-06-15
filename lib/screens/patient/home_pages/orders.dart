import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/models/data_providers.dart';
import 'package:medical_app/models/order.dart';
import 'package:medical_app/screens/patient/detail_order.dart';
import 'package:provider/provider.dart';

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
    final order = Provider.of<OrderProvider>(context, listen: false);
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
                ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, position) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
                      color: Colors.grey[300],
                      child: ExpansionTile(
                        leading: IconButton(
                          icon: Icon(Icons.mail),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => DetailOrderScreen()));
                          },
                        ),
                        title: Row(
                          children: <Widget>[
                            Consumer<OrderProvider>(
                              builder: (_, order, __) =>
                                  Text("Заказ ${order.id}"),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.info,
                              color: Colors.orange,
                            )
                          ],
                        ),
                        subtitle: Consumer<OrderProvider>(
                          builder: (_, order, __) => Text("от ${order.date}"),
                        ),
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 0, 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Статус:",
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(24.0),
                                        color:
                                            Color.fromRGBO(228, 239, 243, 1.0),
                                        child: Consumer<OrderProvider>(
                                          builder: (_, order, __) =>
                                              Text(order.status),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 0, 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Врач:",
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(24.0),
                                        color:
                                            Color.fromRGBO(228, 239, 243, 1.0),
                                        child: Text("Иванов Иван Иванович"),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 0, 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Адрес:",
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(24.0),
                                        color:
                                            Color.fromRGBO(228, 239, 243, 1.0),
                                        child: Consumer<OrderProvider>(
                                          builder: (_, order, __) =>
                                              Text(order.address),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 8, 0, 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Комментарий пациента:",
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(24.0),
                                          color: Color.fromRGBO(
                                              228, 239, 243, 1.0),
                                          child: Consumer<OrderProvider>(
                                            builder: (_, order, __) =>
                                                Text(order.userComment),
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 8, 0, 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Комментарий врача:",
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(24.0),
                                        color:
                                            Color.fromRGBO(228, 239, 243, 1.0),
                                        child: Consumer<OrderProvider>(
                                          builder: (_, order, __) =>
                                              Text(order.doctorComment),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 8, 0, 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Связанные вызовы:",
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          width: double.infinity,
                                          // padding: EdgeInsets.all(24.0),
                                          color: Color.fromRGBO(
                                              228, 239, 243, 1.0),
                                          child: Column(
                                            children: <Widget>[
                                              ListTile(
                                                title: Center(
                                                  child: Text("20-04-2020"),
                                                ),
                                              ),
                                              ListTile(
                                                title: Center(
                                                  child: Text("20-04-2020"),
                                                ),
                                              ),
                                              ListTile(
                                                title: Center(
                                                  child: Text("20-04-2020"),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, position) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
                      color: Colors.grey[300],
                      child: ExpansionTile(
                        leading: IconButton(
                          icon: Icon(Icons.mail),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => DetailOrderScreen()));
                          },
                        ),
                        title: Row(
                          children: <Widget>[
                            Consumer<OrderProvider>(
                              builder: (_, order, __) =>
                                  Text("Заказ ${order.id}"),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          ],
                        ),
                        subtitle: Consumer<OrderProvider>(
                          builder: (_, order, __) => Text("от ${order.date}"),
                        ),
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 0, 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Статус:",
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(24.0),
                                        color:
                                            Color.fromRGBO(228, 239, 243, 1.0),
                                        child: Consumer<OrderProvider>(
                                          builder: (_, order, __) =>
                                              Text(order.status),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 0, 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Врач:",
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(24.0),
                                        color:
                                            Color.fromRGBO(228, 239, 243, 1.0),
                                        child: Text("Иванов Иван Иванович"),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 0, 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Адрес:",
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(24.0),
                                        color:
                                            Color.fromRGBO(228, 239, 243, 1.0),
                                        child: Consumer<OrderProvider>(
                                          builder: (_, order, __) =>
                                              Text(order.address),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 8, 0, 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Комментарий пациента:",
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(24.0),
                                        color:
                                            Color.fromRGBO(228, 239, 243, 1.0),
                                        child: Consumer<OrderProvider>(
                                          builder: (_, order, __) =>
                                              Text(order.userComment),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 8, 0, 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Комментарий врача:",
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(24.0),
                                        color:
                                            Color.fromRGBO(228, 239, 243, 1.0),
                                        child: Consumer<OrderProvider>(
                                          builder: (_, order, __) =>
                                              Text(order.doctorComment),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 8, 0, 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Связанные вызовы:",
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          width: double.infinity,
                                          // padding: EdgeInsets.all(24.0),
                                          color: Color.fromRGBO(
                                              228, 239, 243, 1.0),
                                          child: Column(
                                            children: <Widget>[
                                              ListTile(
                                                title: Center(
                                                  child: Text("20-04-2020"),
                                                ),
                                              ),
                                              ListTile(
                                                title: Center(
                                                  child: Text("20-04-2020"),
                                                ),
                                              ),
                                              ListTile(
                                                title: Center(
                                                  child: Text("20-04-2020"),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
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
