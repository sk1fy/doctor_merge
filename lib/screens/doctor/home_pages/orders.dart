import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/models/data_providers.dart';
import 'package:medical_app/screens/doctor/detail_order.dart';
import 'package:provider/provider.dart';

class CustomTabs extends StatefulWidget {
  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
      return Consumer<OrderProvider>(
        builder: (_, order, child) => Container(
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
                Text("Заказ ${order.order.id}"),
                SizedBox(width: 10),
                Icon(
                  Icons.info,
                  color: Colors.orange,
                )
              ],
            ),
            subtitle: Text("от ${order.order.date}"),
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
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: GestureDetector(
                                    child: Icon(
                                      Icons.check_circle,
                                      // color: Colors.green[600],
                                    ),
                                    onTap: () => {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text(
                                              'Изменение статуса заказа'),
                                          content: Text(
                                              'Вы хотите изменить статус заказа на "Завершен"'),
                                          actions: <Widget>[
                                            FlatButton(
                                                child: Text('Да'),
                                                onPressed: () => {
                                                      print('Complete'),
                                                      Navigator.pop(context),
                                                    }),
                                            FlatButton(
                                              child: Text('Нет'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                      ),
                                    },
                                  ),
                                )
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
                                  "Пациент:",
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
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: GestureDetector(
                                    child:
                                        Icon(Icons.edit, color: Colors.black87),
                                    onTap: () => {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (ctx) =>
                                              _buildEditBottomSheet(ctx)),
                                    },
                                  ),
                                )
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
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: GestureDetector(
                                    child: Icon(Icons.playlist_add,
                                        color: Colors.black87),
                                    onTap: () => {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (ctx) => AddBottomSheet()),
                                    },
                                  ),
                                )
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildOrdersListComplete() {
  return ListView.builder(
    itemBuilder: (context, position) {
      return Consumer<OrderProvider>(
        builder: (_, order, child) => Container(
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
                Text("Заказ ${order.order.id}"),
                SizedBox(width: 10),
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              ],
            ),
            subtitle: Text("от ${order.order.date}"),
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

Container _buildEditBottomSheet(BuildContext context) {
  return Container(
    height: 400,
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue, width: 2.0),
    ),
    child: ListView(
      children: <Widget>[
        ListTile(title: Text('Коментарии врача:')),
        TextField(
          maxLines: 4,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '...',
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          alignment: Alignment.center,
          child: RaisedButton.icon(
            icon: Icon(
              Icons.save,
              color: Colors.blue,
            ),
            label: Text('Сохранить и закрыть',
                style: TextStyle(color: Colors.blue, fontSize: 16)),
            onPressed: () => Navigator.pop(context),
          ),
        )
      ],
    ),
  );
}

class AddBottomSheet extends StatefulWidget {
  @override
  _AddBottomSheetState createState() => _AddBottomSheetState();
}

DateTime _dataTimeLinkedCall;

class _AddBottomSheetState extends State<AddBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
      ),
      child: ListView(
        children: <Widget>[
          ListTile(title: Text('Добавить вызов:')),
          FlatButton(
            onPressed: () async {
              DatePicker.showDateTimePicker(context, showTitleActions: true,
                  onChanged: (date) {
                print('change $date in time zone ' +
                    date.timeZoneOffset.inHours.toString());
              }, onConfirm: (date) {
                print('confirm $date');
                _dataTimeLinkedCall = date;
                setState(() {});
              }, currentTime: DateTime.now(), locale: LocaleType.ru);
            },
            child: Row(
              mainAxisAlignment: _dataTimeLinkedCall == null
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: <Widget>[
                _dataTimeLinkedCall == null
                    ? Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      )
                    : Container(),
                Text(
                  // '${_dataTimeLinkedCall == null ? 'Нажмите для выбора даты и времени' : _dataTimeLinkedCall.toString().substring(0, 19)}',
                  '${_dataTimeLinkedCall == null ? 'Нажмите для выбора даты и времени' : DateFormat('dd.MM.yy hh:mm:ss', 'en_US').format(_dataTimeLinkedCall)}',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            child: RaisedButton.icon(
              icon: Icon(
                Icons.save,
                color: Colors.blue,
              ),
              label: Text('Сохранить и закрыть',
                  style: TextStyle(color: Colors.blue, fontSize: 16)),
              onPressed: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }
}
