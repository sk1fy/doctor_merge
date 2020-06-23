import 'package:flutter/material.dart';
import 'package:medical_app/models/data_providers.dart';
import 'package:provider/provider.dart';

class CallDoctorScreen extends StatefulWidget {
  @override
  _CallDoctorScreenState createState() => _CallDoctorScreenState();
}

class _CallDoctorScreenState extends State<CallDoctorScreen> {
  GlobalKey _globalKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String select = 'Выберите врача..';
  bool _approve = false;
  DateTime _dataInfo;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Вызов педиатра"),
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
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              filled: true,
                              labelText: "Номер телефона",
                              labelStyle: TextStyle(color: Colors.black),
                              hintText: '+7(000)0000000',
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
                              "Выберите нужного специалиста. В случае если вы выбираете конктрентного специалиста, время назначает сам врач!",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 13.5)),
                        ],
                      ),
                    ),
                    Container(
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
                          SizedBox(
                            height: 10,
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
                                  child: ListView(
                                    children: <Widget>[
                                      new ListTile(
                                        title:
                                            const Text('Иванов Иван Иванович'),
                                        onTap: () {
                                          setState(() {
                                            this.select =
                                                'Иванов Иван Иванович';
                                            _globalKey = GlobalKey();
                                          });
                                        },
                                      ),
                                      new ListTile(
                                        title: const Text(
                                            'Сидоров Павел Сергеевич'),
                                        onTap: () {
                                          setState(() {
                                            this.select =
                                                'Сидоров Павел Сергеевич';
                                            _globalKey = GlobalKey();
                                          });
                                        },
                                      ),
                                      new ListTile(
                                        title:
                                            const Text('Петров Петр Петрович'),
                                        onTap: () {
                                          setState(() {
                                            this.select =
                                                'Петров Петр Петрович';
                                            _globalKey = GlobalKey();
                                          });
                                        },
                                      ),
                                      new ListTile(
                                        title: const Text(
                                            'Петров Александр Петрович'),
                                        onTap: () {
                                          setState(() {
                                            this.select =
                                                'Петров Александр Петрович';
                                            _globalKey = GlobalKey();
                                          });
                                        },
                                      ),
                                      new ListTile(
                                        title: const Text(
                                            'Петров Евгений Петрович'),
                                        onTap: () {
                                          setState(() {
                                            this.select =
                                                'Петров Евгений Петрович';
                                            _globalKey = GlobalKey();
                                          });
                                        },
                                      ),
                                      new ListTile(
                                        title:
                                            const Text('Петров Илья Петрович'),
                                        onTap: () {
                                          setState(() {
                                            this.select =
                                                'Петров Илья Петрович';
                                            _globalKey = GlobalKey();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
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
                                "Время и дата:",
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
                                final dtPick = await showDatePicker(
                                    context: context,
                                    initialDate: new DateTime.now(),
                                    firstDate: new DateTime.now(),
                                    lastDate: new DateTime(2022));

                                if (dtPick != null && dtPick != _dataInfo) {
                                  setState(() {
                                    _dataInfo = dtPick;
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('${_dataInfo}'),
                                  Icon(Icons.calendar_today),
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
                            maxLines: 10,
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
                      Container(
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
                            if (!_formKey.currentState.validate()) {
                              return;
                            }

                            _formKey.currentState.save();

                            //Send to API
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
