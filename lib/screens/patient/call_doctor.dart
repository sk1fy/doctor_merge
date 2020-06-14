import 'package:flutter/material.dart';

class CallDoctorScreen extends StatefulWidget {
  @override
  _CallDoctorScreenState createState() => _CallDoctorScreenState();
}

class _CallDoctorScreenState extends State<CallDoctorScreen> {
  GlobalKey _globalKey = GlobalKey();
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
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
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
                        hintText: 'ул.Байкальская 10',
                        fillColor: Color.fromRGBO(228, 239, 243, 1.0)),
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
                                title: const Text('Иванов Иван Иванович'),
                                onTap: () {
                                  setState(() {
                                    this.select = 'Иванов Иван Иванович';
                                    _globalKey = GlobalKey();
                                  });
                                },
                              ),
                              new ListTile(
                                title: const Text('Сидоров Павел Сергеевич'),
                                onTap: () {
                                  setState(() {
                                    this.select = 'Сидоров Павел Сергеевич';
                                    _globalKey = GlobalKey();
                                  });
                                },
                              ),
                              new ListTile(
                                title: const Text('Петров Петр Петрович'),
                                onTap: () {
                                  setState(() {
                                    this.select = 'Петров Петр Петрович';
                                    _globalKey = GlobalKey();
                                  });
                                },
                              ),
                              new ListTile(
                                title: const Text('Петров Александр Петрович'),
                                onTap: () {
                                  setState(() {
                                    this.select = 'Петров Александр Петрович';
                                    _globalKey = GlobalKey();
                                  });
                                },
                              ),
                              new ListTile(
                                title: const Text('Петров Евгений Петрович'),
                                onTap: () {
                                  setState(() {
                                    this.select = 'Петров Евгений Петрович';
                                    _globalKey = GlobalKey();
                                  });
                                },
                              ),
                              new ListTile(
                                title: const Text('Петров Илья Петрович'),
                                onTap: () {
                                  setState(() {
                                    this.select = 'Петров Илья Петрович';
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
                      child: FlatButton(onPressed: () async {
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
                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        Text('${_dataInfo}'),
                        Icon(Icons.calendar_today),
                      ],))),
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
                  TextField(
                    maxLines: 10,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: 'Комментраии:',
                      hintText: '...',
                      border: OutlineInputBorder(),
                    ),
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
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.white),
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
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              width: double.infinity,
              child: RaisedButton(
                elevation: 5.0,
                onPressed: () => null,
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
              ),
            ),
          ],
        ),
      )),
    ));
  }
}
