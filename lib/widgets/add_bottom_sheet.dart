import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/models/call.dart';
import 'package:medical_app/models/network.dart';

class AddBottomSheet extends StatefulWidget {
  String orderId;
  AddBottomSheet({this.orderId});
  @override
  _AddBottomSheetState createState() => _AddBottomSheetState();
}
// String ord = orderId;
List<Call> connectedCalls;
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
              onPressed: () =>  addConnectedCall(context, '5f0c268e5c7e4e044f2a7f30'),
            ),
          )
        ],
      ),
    );
  }

  Future addConnectedCall(context, id) async {
    String call = _dataTimeLinkedCall.toString();
    try {
      await AuthNetwork.of(context).addCallToOrder(id, call);
    } catch (err) {
      print(err);
    }
    Navigator.pop(context);
    print(call);
  }
}
