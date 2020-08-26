import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/models/call.dart';
import 'package:medical_app/models/data_providers.dart';
import 'package:medical_app/models/network.dart';
import 'package:provider/provider.dart';

class AddCall extends StatefulWidget {
  final String orderId;
  final String medic;
  AddCall({this.orderId, this.medic});

  @override
  _AddCallState createState() => _AddCallState();
}

class _AddCallState extends State<AddCall> {
  String orderId;
  List connectedCalls = [];
  bool _agree = false;
  DateTime _dataTimeLinkedCall;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить вызов:'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Spacer(),
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
                    ? MainAxisAlignment.spaceAround
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
                    '${_dataTimeLinkedCall == null ? 'Нажмите для выбора даты и времени' : DateFormat(
                        'Дата: dd MMMM yyyy,  Время: HH:mm',
                      ).format(_dataTimeLinkedCall)}',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: SwitchListTile(
                onChanged: (_) {
                  setState(() {
                    _agree = _;
                  });
                },
                value: _agree,
                title: Text("Последний вызов"),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _dataTimeLinkedCall != null
                    ? Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: RaisedButton.icon(
                          icon: Icon(
                            Icons.send,
                            color: Colors.blue,
                          ),
                          label: Text('Отправить',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16)),
                          onPressed: () =>
                              sendConnectedCall(widget.orderId, widget.medic),
                        ),
                      )
                    : Container(),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Future sendConnectedCall(order, medic) async {
    final callAgree = _agree == false ? 'Active' : 'Ended';
    final datetime = _dataTimeLinkedCall.toString();
    try {
      await AuthNetwork.of(context).addCall(order, medic, callAgree, datetime);
      _dataTimeLinkedCall = null;
      Navigator.pop(context);
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Вызовы добавлен'),
          actions: <Widget>[
            FlatButton(
              child: Text('Окей'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } catch (err) {
      print(err);
    }
  }

//   Future addConnectedCall(context, id) async {
//     final order = Provider.of<OrderProvider>(context, listen: false);
//     var call = Call(datetime: _dataTimeLinkedCall);
//     var calls = Call(datetime: _dataTimeLinkedCall).toJson();

//     if (order.order.connectedCalls == null) {
//       order.order.connectedCalls = [];
//       order.order.connectedCalls.add(call);
//     }

//     if (widget.orderId != id) {
//       connectedCalls.clear();
//     }
//     if (_dataTimeLinkedCall == null) {
//       showDialog<String>(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Выбирите дату'),
//           actions: <Widget>[
//             FlatButton(
//               child: Text('Окей'),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ],
//         ),
//       );
//     } else {
//       try {
//         connectedCalls.add(calls);
//         order.order.connectedCalls.add(call);
//         showDialog<String>(
//           context: context,
//           builder: (BuildContext context) => AlertDialog(
//             title: const Text('Вызов добавлен'),
//             content: Text(
//                 'Для добавления ещё вызовов укажите новую дату и время, чтобы увидеть изменеия заявки перезайдите во вкладку "Заказы"',
//                 style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text('Окей'),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ],
//           ),
//         );
//         widget.orderId = id;
//         _dataTimeLinkedCall = null;
//       } catch (err) {
//         print(err);
//       }
//     }
//     print(connectedCalls);
//   }
}
