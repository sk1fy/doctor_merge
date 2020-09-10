import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:medical_app/models/call.dart';
import 'package:medical_app/models/network.dart';
import 'package:medical_app/models/order.dart';
import 'package:medical_app/models/users_provider.dart';
import 'package:medical_app/screens/doctor/add_call.dart';
import 'package:medical_app/utilities/constans.dart';
import 'package:medical_app/utilities/http_service.dart';
import 'package:medical_app/widgets/detail_order.dart';
import 'package:medical_app/widgets/edit_bottom_sheet.dart';
import 'package:provider/provider.dart';

class OrderList extends StatelessWidget {
  final Order orderState;
  final HttpService httpService = HttpService();
  final String currentStatus;
  final String typeUser;
  OrderList({this.currentStatus, this.orderState, this.typeUser});

  @override
  Widget build(BuildContext context) {
    final clients = Provider.of<UsersProvider>(context, listen: false);
    initializeDateFormatting('ru_RU', null);
    return FutureBuilder(
      future: httpService.getOrderList(
          typeUser == 'medic' ? clients.doctor.id : clients.user.id,
          currentStatus,
          typeUser),
      builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
        List<Order> orders = snapshot.data;
        if (snapshot.hasData) {
          return ListView(
            children: orders
                .map(
                  (Order order) => Container(
                    margin: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
                    color: Colors.grey[300],
                    child: ExpansionTile(
                      leading: IconButton(
                        icon: Icon(Icons.mail),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => DetailOrderScreen(
                                      orderId: order.id,
                                      type: Constants.prefs.getBool("type") ==
                                              true
                                          ? '1'
                                          : '0')));
                        },
                      ),
                      title: Row(
                        children: <Widget>[
                          Text("№ ${order.id.substring(0, 8)}"),
                          SizedBox(width: 10),
                          order.status == 'Active'
                              ? Icon(
                                  Icons.info,
                                  color: Colors.orange,
                                )
                              : Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                        ],
                      ),
                      subtitle: Text(
                        DateFormat('dd.MM.yyyy', 'ru_RU')
                            .format(DateTime.parse(order.date)),
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
                                      color: Color.fromRGBO(228, 239, 243, 1.0),
                                      child: Text(order.status == 'Active'
                                          ? 'Активный'
                                          : 'Завершен'),
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
                                      color: Color.fromRGBO(228, 239, 243, 1.0),
                                      child: Text(order.address),
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
                                      color: Color.fromRGBO(228, 239, 243, 1.0),
                                      child: Text(order.clientComment),
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
                                          Spacer(),
                                          order.status == 'Active' &&
                                                  typeUser == 'medic'
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: GestureDetector(
                                                    child: Icon(Icons.edit,
                                                        color: Colors.black87),
                                                    onTap: () => {
                                                      showModalBottomSheet(
                                                          context: context,
                                                          builder: (ctx) =>
                                                              EditBottomSheet(
                                                                  orderId: order
                                                                      .id)),
                                                    },
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    order.medicComment == null
                                        ? Container()
                                        : Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.all(24.0),
                                            color: Color.fromRGBO(
                                                228, 239, 243, 1.0),
                                            child: Text(order.medicComment),
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
                                            "Следующие вызовы:",
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                          Spacer(),
                                          order.status == 'Active' &&
                                                  typeUser == 'medic'
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: GestureDetector(
                                                    child: Icon(
                                                        Icons.playlist_add,
                                                        color: Colors.black87),
                                                    onTap: () => {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (ctx) => AddCall(
                                                                  orderId:
                                                                      order.id,
                                                                  medic: clients
                                                                      .doctor
                                                                      .id))),
                                                      // showModalBottomSheet(
                                                      //     context: context,
                                                      //     builder: (ctx) =>
                                                      //         AddBottomSheet(
                                                      //             orderId: order
                                                      //                 .id)),
                                                    },
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        width: double.infinity,
                                        // padding: EdgeInsets.all(24.0),
                                        child: FutureBuilder(
                                          future: httpService
                                              .getCalls(order.id), // async work
                                          builder: (BuildContext context,
                                              AsyncSnapshot<List<Call>>
                                                  snapshot) {
                                            List<Call> calls = snapshot.data;
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.waiting:
                                                return Center(
                                                  child: SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child:
                                                          CircularProgressIndicator()),
                                                );
                                              default:
                                                if (snapshot.hasError)
                                                  return Text(
                                                      'Error: ${snapshot.error}');
                                                else
                                                  return Column(
                                                    children: List.generate(
                                                      calls.length,
                                                      (index) => Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              228,
                                                              239,
                                                              243,
                                                              1.0),
                                                        ),
                                                        child: ListTile(
                                                            leading: Icon(
                                                              Icons.event,
                                                              color: Colors
                                                                  .black87,
                                                            ),
                                                            title: Text(
                                                              DateFormat(
                                                                      'dd MMMM HH:mm',
                                                                      'ru_RU')
                                                                  .format(DateTime.parse(calls[
                                                                          index]
                                                                      .datetime
                                                                      .toString())),
                                                            ),
                                                            trailing: calls[index]
                                                                        .status ==
                                                                    'Ended'
                                                                ? Tooltip(
                                                                    child: Icon(
                                                                        Icons
                                                                            .help_outline),
                                                                    preferBelow:
                                                                        false,
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            15),
                                                                    message:
                                                                        'Врач назначил этот вызов последним',
                                                                    excludeFromSemantics:
                                                                        true,
                                                                    showDuration:
                                                                        Duration(
                                                                            milliseconds:
                                                                                2500),
                                                                  )
                                                                : null),
                                                      ),
                                                    ),
                                                  );
                                            }
                                          },
                                        )),
                                    order.status == 'Active' &&
                                            typeUser == 'medic'
                                        ? Container(
                                            margin: EdgeInsets.all(10),
                                            child: FlatButton(
                                              child: Text(
                                                'Завершить',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              onPressed: () {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'Изменение статуса заказа'),
                                                    content: Text(
                                                      'Вы хотите изменить статус заказа на "Завершен".\n Для обновления статуса перейдите в "Завершенные"',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text('Да'),
                                                        onPressed: () =>
                                                            complete(context,
                                                                order.id),
                                                      ),
                                                      FlatButton(
                                                        child: Text('Нет'),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          );
        } else if (snapshot.hashCode == 400) {
          return Center(child: Text('Соединение потеряно'));
        } else if (snapshot.hashCode == 401) {
          return Center(child: Text('Соединение потеряно'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future complete(context, id) async {
    final status = "Ended";
    // print(id);
    try {
      await AuthNetwork.of(context).completeOrder(id, status);
    } catch (err) {
      print(err);
    }
    Navigator.pop(context);
  }
}
