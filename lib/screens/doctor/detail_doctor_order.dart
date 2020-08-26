import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/models/network.dart';
import 'package:medical_app/models/order.dart';
import 'package:medical_app/models/users_provider.dart';
import 'package:medical_app/screens/doctor/home.dart';
import 'package:provider/provider.dart';

class DetailDoctorOrderScreen extends StatelessWidget {
  final Order order;

  DetailDoctorOrderScreen({@required this.order});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    ListTile(title: Text(order.address)),
                    SizedBox(height: 20)
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Дата и время:"),
                    SizedBox(height: 10),
                    ListTile(
                      title: Text(
                        DateFormat('dd.MM.yyyy, HH:mm', 'en_US')
                            .format(DateTime.parse(order.date)),
                      ),
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
                    ListTile(title: Text(order.clientComment)),
                    SizedBox(height: 20)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 25.0),
                width: double.infinity,
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () => update(context),
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
    );
  }

  Future update(context) async {
    final clients = Provider.of<UsersProvider>(context, listen: false);
    final status = "Active";
    final medic = clients.doctor.id;
    final currentOrder = order.id;
    // print(currentOrder);
    // print(medic);
    try {
      await AuthNetwork.of(context).takeOrder(currentOrder, medic, status);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => HomePageDoctor()));
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Заявка принята'),
          content: ListTile(
            title: Text("Адрес: ${order.address}"),
            subtitle: Text(
                "Дата и время вызова: ${DateFormat('dd.MM.yy hh:mm', 'en_US').format(DateTime.parse(order.date))}"),
          ),
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
}
