import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/models/data_providers.dart';
import 'package:medical_app/models/doctor.dart';
import 'package:medical_app/models/network.dart';
import 'package:medical_app/models/users_provider.dart';
import 'package:medical_app/screens/patient/home.dart';
import 'package:medical_app/utilities/http_service.dart';
import 'package:provider/provider.dart';

class CallDoctorScreen extends StatefulWidget {
  final String title;
  CallDoctorScreen({Key key, @required this.title}) : super(key: key);
  @override
  _CallDoctorScreenState createState() => _CallDoctorScreenState();
}

final TextEditingController _addressController = TextEditingController();
final TextEditingController _commentController = TextEditingController();

class _CallDoctorScreenState extends State<CallDoctorScreen> {
  final HttpService httpService = HttpService();
  GlobalKey _globalKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String select = 'Выберите врача..';
  String docID;
  bool _approve = false;
  bool switcher = false;
  DateTime _dataInfo;

  @override
  Widget build(BuildContext context) {
    final clients = Provider.of<UsersProvider>(context, listen: false);
    _addressController.text = clients.user.address;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Вызов ${widget.title}a'),
        ),
        body: SingleChildScrollView(
          child: Consumer<OrderProvider>(
            builder: (_, order, child) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Адрес:",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _addressController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              filled: true,
                              // labelText: "Адрес",
                              // labelStyle: TextStyle(color: Colors.black),
                              hintText: 'г.Удан-Удэ,ул.Байкальская 1',
                              fillColor: Color.fromRGBO(228, 239, 243, 1.0),
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Пожадуйста введите правильный адрес';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          Text(
                              "В случае если вы выбираете конктрентного специалиста, время назначает сам врач!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 13.5)),
                        ],
                      ),
                    ),
                    SwitchListTile(
                      onChanged: (_) {
                        setState(() {
                          switcher = _;
                        });
                      },
                      value: switcher,
                      title: Text("Выбрать врача"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    switcher == true
                        ? Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Врач:",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                                ExpansionTile(
                                  key: _globalKey,
                                  title: new Text(
                                    this.select,
                                    style: TextStyle(color: Colors.grey[800]),
                                  ),
                                  children: <Widget>[
                                    Container(
                                      height: 190,
                                      color: Color.fromRGBO(228, 239, 243, 1.0),
                                      child: FutureBuilder(
                                        future: httpService.getDoctorToCall(
                                            '?specialty=${widget.title}'),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<List<Doctor>>
                                                snapshot) {
                                          if (snapshot.hasData) {
                                            List<Doctor> doctors =
                                                snapshot.data;
                                            return ListView(
                                              children: doctors
                                                  .map(
                                                    (Doctor doctor) => ListTile(
                                                      title: Text(doctor.name),
                                                      onTap: () {
                                                        setState(() {
                                                          this.select =
                                                              doctor.name;
                                                          this.docID =
                                                              doctor.id;
                                                          _globalKey =
                                                              GlobalKey();
                                                        });
                                                      },
                                                    ),
                                                  )
                                                  .toList(),
                                            );
                                          } else {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Дата и время:",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  color: Color.fromRGBO(228, 239, 243, 1.0),
                                  height: 50,
                                  child: FlatButton(
                                    onPressed: () async {
                                      DatePicker.showDateTimePicker(context,
                                          showTitleActions: true,
                                          onChanged: (date) {
                                        print('change $date in time zone ' +
                                            date.timeZoneOffset.inHours
                                                .toString());
                                      }, onConfirm: (date) {
                                        print('confirm $date');
                                        _dataInfo = date;
                                        setState(() {});
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.ru);
                                    },
                                    child: Row(
                                      mainAxisAlignment: _dataInfo == null
                                          ? MainAxisAlignment.spaceBetween
                                          : MainAxisAlignment.center,
                                      children: <Widget>[
                                        _dataInfo == null
                                            ? Icon(
                                                Icons.calendar_today,
                                                color: Colors.grey,
                                              )
                                            : Container(),
                                        Text(
                                          // '${_dataInfo == null ? 'Нажмите для выбора даты и времени' : _dataInfo.toString().substring(0, 19)}',
                                          '${_dataInfo == null ? 'Нажмите для выбора даты и времени' : DateFormat('dd.MM.yy hh:mm:ss', 'en_US').format(_dataInfo)}',
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Комментарии:",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _commentController,
                            maxLines: 5,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              hintText: '...',
                              border: OutlineInputBorder(),
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Пожалуйста заполните данное поле';
                              }
                              return null;
                            },
                            onChanged: (text) => setState(() {}),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 20.0,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Theme(
                            data: ThemeData(
                                unselectedWidgetColor: Colors.grey[400]),
                            child: Checkbox(
                              value: _approve,
                              checkColor: Colors.blue,
                              activeColor: Colors.white,
                              onChanged: (value) {
                                setState(() {
                                  _approve = value;
                                });
                              },
                            ),
                          ),
                          Text(
                            'Я принимаю условия',
                          ),
                        ],
                      ),
                    ),
                    if (_approve)
                      switcher == false
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              width: double.infinity,
                              child: RaisedButton(
                                elevation: 5.0,
                                padding: EdgeInsets.all(20.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                color: Color.fromRGBO(104, 169, 196, 1.0),
                                child: Text(
                                  'Сделать заказ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    if (_dataInfo == null) {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text(
                                              'Выберите дату и время'),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('Закрыть'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      print(_dataInfo);
                                      sendOrder(context);
                                      _addressController.clear();
                                      _commentController.clear();
                                    }
                                  }
                                  _formKey.currentState.save();
                                  //Send to API
                                },
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              width: double.infinity,
                              child: RaisedButton(
                                elevation: 5.0,
                                padding: EdgeInsets.all(20.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                color: Color.fromRGBO(104, 169, 196, 1.0),
                                child: Text(
                                  'Сделать заказ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    if (select == 'Выберите врача..') {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Выберите врача'),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('Закрыть'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      sendOrder(context);
                                      _addressController.clear();
                                      _commentController.clear();
                                    }
                                  }
                                  _formKey.currentState.save();
                                  //Send to API
                                },
                              ),
                            )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future sendOrder(context) async {
    final clients = Provider.of<UsersProvider>(context, listen: false);
    final address = _addressController.value.text;
    final comments = _commentController.value.text;
    final client = clients.user.id;
    final date =
        _dataInfo == null ? DateTime.now().toString() : _dataInfo.toString();
    final specialization = widget.title;
    final medic = docID == null ? null : docID;
    final status = docID == null ? 'New' : 'Active';
    try {
      await AuthNetwork.of(context).createOrder(
          client, date, medic, specialization, address, comments, status);
      Navigator.pop(context);
      MaterialPageRoute(builder: (ctx) => HomePagePatient());
    } catch (err) {
      print(err);
    }
  }
}
