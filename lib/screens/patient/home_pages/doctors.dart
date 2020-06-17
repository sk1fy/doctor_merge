import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/models/data_providers.dart';
import 'package:medical_app/screens/patient/test.dart';
import 'package:provider/provider.dart';


class DoctorPage extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

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

class _DoctorPageState extends State<DoctorPage> {
  List doctors = [];
  List filteredDoctors = [];

  getDoctors() async {
    var response = await Dio().get('https://jsonplaceholder.typicode.com/users');
    return response.data;
  }

  @override
  void initState() {
    getDoctors().then((data) {
      setState(() {
        doctors = filteredDoctors = data;
      });
    });
    super.initState();
  }

  void _filterDoctors(value) {
    setState(() {
      filteredDoctors = doctors
          .where((doctor) =>
              doctor['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final doctor = Provider.of<DoctorProvider>(context, listen: false);

    return Column(
      children: <Widget>[
        Container(
          color: Color.fromRGBO(33, 153, 252, 1.0),
          height: 50.0,
          child: Center(
            child: TextField(
              onChanged: (value) {
                _filterDoctors(value);
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Найти врача",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        Container(
          height: 130.0,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0),
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Категории",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  height: 78.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          onPressed: () => null,
                          color: Color.fromRGBO(33, 153, 252, 1.0),
                          textColor: Colors.white,
                          padding: EdgeInsets.all(18),
                          child: Column(
                            // Replace with a Row for horizontal icon + text
                            children: <Widget>[
                              Icon(Icons.person_outline),
                              Text("Педиатр")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          onPressed: () => null,
                          color: Color.fromRGBO(33, 153, 252, 1.0),
                          textColor: Colors.white,
                          padding: EdgeInsets.all(18),
                          child: Column(
                            // Replace with a Row for horizontal icon + text
                            children: <Widget>[
                              Icon(Icons.person_outline),
                              Text("Педиатр")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                child: filteredDoctors.length > 0
                    ? ListView.builder(
                        itemCount: filteredDoctors.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => TestScreen()));
                            },
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      // filteredDoctors[index]['name'],
                                      doctor.doctor.name,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      // filteredDoctors[index]['company']['name'],
                                      doctor.doctor.specialty,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
