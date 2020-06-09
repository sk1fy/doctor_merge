import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/models/order.dart';
import 'package:medical_app/screens/detail_order.dart';

import '../models/order.dart';

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
                _buildOrdersList(),
                _buildOrdersListComplete(),
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

Widget _buildOrdersList() {
  return ListView.builder(
    itemBuilder: (context, position) {
      return Container(
        margin: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
        color: Colors.grey[300],
        child: ExpansionTile(
          leading: IconButton(
            icon: Icon(Icons.mail),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => DetailOrderScreen()));
            },
          ),
          title: Row(
            children: <Widget>[
              Text("Заказ 1231234112"),
              SizedBox(width: 10),
              Icon(
                Icons.info,
                color: Colors.orange,
              )
            ],
          ),
          subtitle: Text("от 12.12.4444"),
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Color.fromRGBO(228, 239, 243, 1.0),
                          child: Text("Новый"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Color.fromRGBO(228, 239, 243, 1.0),
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
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Color.fromRGBO(228, 239, 243, 1.0),
                          child: Text("г. Иркутск, ул. Байкальская 10"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 8, 0, 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Color.fromRGBO(228, 239, 243, 1.0),
                          child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ac ultrices blandit elit nisl nisi quam. Potenti egestas purus mattis in. Duis erat purus eget risus velit feugiat risus amet. Lacus nisi, accumsan egestas massa eget odio mi penatibus. Lectus semper dui lectus habitant sit quis elementum suspendisse. Auctor vitae feugiat dignissim ipsum vivamus."),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 8, 0, 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Color.fromRGBO(228, 239, 243, 1.0),
                          child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ac ultrices blandit elit nisl nisi quam. Potenti egestas purus mattis in. Duis erat purus eget risus velit feugiat risus amet. Lacus nisi, accumsan egestas massa eget odio mi penatibus. Lectus semper dui lectus habitant sit quis elementum suspendisse. Auctor vitae feugiat dignissim ipsum vivamus."),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 8, 0, 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                            color: Color.fromRGBO(228, 239, 243, 1.0),
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
  );
}

Widget _buildOrdersListComplete() {
  return ListView.builder(
    itemBuilder: (context, position) {
      return Container(
        margin: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
        color: Colors.grey[300],
        child: ExpansionTile(
          leading: IconButton(
            icon: Icon(Icons.mail),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => DetailOrderScreen()));
            },
          ),
          title: Row(
            children: <Widget>[
              Text("Заказ 1231234112"),
              SizedBox(width: 10),
              Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            ],
          ),
          subtitle: Text("от 12.12.4444"),
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Color.fromRGBO(228, 239, 243, 1.0),
                          child: Text("Завершен"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Color.fromRGBO(228, 239, 243, 1.0),
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
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Color.fromRGBO(228, 239, 243, 1.0),
                          child: Text("г. Иркутск, ул. Байкальская 10"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 8, 0, 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Color.fromRGBO(228, 239, 243, 1.0),
                          child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ac ultrices blandit elit nisl nisi quam. Potenti egestas purus mattis in. Duis erat purus eget risus velit feugiat risus amet. Lacus nisi, accumsan egestas massa eget odio mi penatibus. Lectus semper dui lectus habitant sit quis elementum suspendisse. Auctor vitae feugiat dignissim ipsum vivamus."),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 8, 0, 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Color.fromRGBO(228, 239, 243, 1.0),
                          child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ac ultrices blandit elit nisl nisi quam. Potenti egestas purus mattis in. Duis erat purus eget risus velit feugiat risus amet. Lacus nisi, accumsan egestas massa eget odio mi penatibus. Lectus semper dui lectus habitant sit quis elementum suspendisse. Auctor vitae feugiat dignissim ipsum vivamus."),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 8, 0, 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                            color: Color.fromRGBO(228, 239, 243, 1.0),
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
  );
}

class _OrderPageState extends State<OrderPage> {

  @override
  Widget build(BuildContext context) {
    return CustomTabs();
  }
}
