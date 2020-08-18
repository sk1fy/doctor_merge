import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/models/call.dart';
import 'package:medical_app/models/data_providers.dart';
import 'package:medical_app/models/network.dart';
import 'package:provider/provider.dart';

class AddBottomSheet extends StatefulWidget {
  final String orderId;
  AddBottomSheet({this.orderId});
  @override
  _AddBottomSheetState createState() => _AddBottomSheetState();
}

String orderId;
List connectedCalls = [];
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
                  '${_dataTimeLinkedCall == null ? 'Нажмите для выбора даты и времени' : DateFormat('dd.MM.yy hh:mm:ss', 'en_US').format(_dataTimeLinkedCall)}',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _dataTimeLinkedCall != null
                  ? Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: RaisedButton.icon(
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: Colors.blue,
                        ),
                        label: Text('Добавить',
                            style: TextStyle(color: Colors.blue, fontSize: 16)),
                        onPressed: () =>
                            addConnectedCall(context, widget.orderId),
                      ),
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: RaisedButton.icon(
                  icon: Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                  label: Text('Отправить',
                      style: TextStyle(color: Colors.blue, fontSize: 16)),
                  onPressed: () => sendConnectedCall(context, widget.orderId),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future sendConnectedCall(context, id) async {
    try {
      await AuthNetwork.of(context).addCallToOrder(context, id, connectedCalls);
      _dataTimeLinkedCall = null;
      Navigator.pop(context);
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Вызовы отправлены'),
          content: Text(
              'Чтобы увидеть изменеия заявки перезайдите во вкладку "Заказы"',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
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

  Future addConnectedCall(context, id) async {
    final order = Provider.of<OrderProvider>(context, listen: false);
    var call = Call(datetime: _dataTimeLinkedCall);
    var calls = Call(datetime: _dataTimeLinkedCall).toJson();

    if (order.order.connectedCalls == null) {
      order.order.connectedCalls = [];
      order.order.connectedCalls.add(call);
    }

    if (orderId != id) {
      connectedCalls.clear();
    }

    try {
      connectedCalls.add(calls);
      order.order.connectedCalls.add(call);
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Вызов добавлен'),
          content: Text(
              'Для добавления ещё вызовов укажите новую дату и время, чтобы увидеть изменеия заявки перезайдите во вкладку "Заказы"',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
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
    orderId = id;
    _dataTimeLinkedCall = null;
    print(connectedCalls);
    // Navigator.pop(context);
  }
}
