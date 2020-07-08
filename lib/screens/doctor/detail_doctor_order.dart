import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/models/data_providers.dart';
import 'package:medical_app/models/network.dart';
import 'package:medical_app/models/order.dart';
import 'package:medical_app/models/users_provider.dart';
import 'package:provider/provider.dart';

class DetailDoctorOrderScreen extends StatelessWidget {
  final Order order;

  DetailDoctorOrderScreen({@required this.order});
  @override
  Widget build(BuildContext context) {
    final clients = Provider.of<UsersProvider>(context, listen: false);
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
                    const Text("Время и дата:"),
                    SizedBox(height: 10),
                    ListTile(
                      title: Text(
                        DateFormat('dd.MM.yy hh:mm', 'en_US')
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
    final orders = Provider.of<OrderProvider>(context, listen: false);
    final clients = Provider.of<UsersProvider>(context, listen: false);
    final status = "Active";
    final medic = clients.doctor.id;
    try {
      await AuthNetwork.of(context).takeOrder(medic, status);
      // Scaffold.of(context)
      //   ..removeCurrentSnackBar()
      //   ..showSnackBar(SnackBar(
      //     content: Text("Заявка принята"),
      //   ));
    } catch (err) {
      print(err);
    }
  }
}
