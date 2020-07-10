import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/models/doctor.dart';
import 'package:medical_app/utilities/http_service.dart';
import 'package:medical_app/utilities/medics.dart';

class DoctorPage extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

final HttpService httpService = HttpService();
final medics = MedicList.docSpeciality;

Widget _buildCategoryButton() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    child: RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      onPressed: () => {},
      color: Color.fromRGBO(33, 153, 252, 1.0),
      textColor: Colors.white,
      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
      child: Column(
        // Replace with a Row for horizontal icon + text
        children: <Widget>[Icon(Icons.person_outline), Text("Педиатр")],
      ),
    ),
  );
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _DoctorPageState extends State<DoctorPage> {
  final _debouncer = Debouncer(milliseconds: 500);
  List<Doctor> doctors = [];
  List<Doctor> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    httpService.getDoctors().then((doctorsFromServer) {
      setState(() {
        doctors = doctorsFromServer;
        filteredDoctors = doctors;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          // color: Color.fromRGBO(33, 153, 252, 1.0),
          padding: EdgeInsets.fromLTRB(10, 0, 50, 0),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.blue, width: 2.0)),
          ),
          height: 50.0,
          child: Center(
            child: TextField(
              textAlign: TextAlign.center,
              onChanged: (string) {
                _debouncer.run(() {
                  setState(() {
                    filteredDoctors = doctors
                        .where((u) => (u.name
                                .toLowerCase()
                                .contains(string.toLowerCase()) ||
                            u.specialty
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                        .toList();
                  });
                });
              },
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                  // hintText: "Найти врача",
                  labelText: 'Найти врача',
                  labelStyle: TextStyle(color: Colors.blue),
                  hintStyle: TextStyle(color: Colors.blue)),
            ),
          ),
        ),
        Expanded(
          child: Container(
            // margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 15),
            padding: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                child: RefreshIndicator(
                  onRefresh: () async {
                    httpService.getDoctors().then((doctorsFromServer) {
                      setState(() {
                        doctors = doctorsFromServer;
                        filteredDoctors = doctors;
                      });
                    });
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemCount: filteredDoctors.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                filteredDoctors[index].name ?? 'Новый врач',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                filteredDoctors[index].specialty ?? 'Не выбрана специальность',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
