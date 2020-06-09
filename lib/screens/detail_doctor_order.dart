import 'package:flutter/material.dart';

class DetailDoctorOrderScreen extends StatefulWidget {
  @override
  _DetailDoctorOrderScreenState createState() =>
      _DetailDoctorOrderScreenState();
}

class _DetailDoctorOrderScreenState extends State<DetailDoctorOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Откликнуться на заказ"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Адрес:"),
                      SizedBox(height: 10),
                      ListTile(
                        title: Text("ул.Пушкина 6"),
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Время и дата:"),
                      SizedBox(height: 10),
                      ListTile(
                        title: Text("25-04-2020г - 10:00"),
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Комментарий пациента:"),
                      SizedBox(height: 10),
                      ListTile(
                        title: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ac ultrices blandit elit nisl nisi quam. Potenti egestas purus mattis in. Duis erat purus eget risus velit feugiat risus amet. Lacus nisi, accumsan egestas massa eget odio mi penatibus. Lectus semper dui lectus habitant sit quis elementum suspendisse. Auctor vitae feugiat dignissim ipsum vivamus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ac ultrices blandit elit nisl nisi quam. Potenti egestas purus mattis in. Duis erat purus eget risus velit feugiat risus amet. Lacus nisi, accumsan egestas massa eget odio mi penatibus."),
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () => {
                      print("Press F")
                    },
                    padding: EdgeInsets.all(20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    color: Color.fromRGBO(104, 169, 196, 1.0),
                    child: Text(
                      'Откликнуться',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
