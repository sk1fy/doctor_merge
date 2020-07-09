import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/models/order.dart';
import 'package:medical_app/models/users_provider.dart';
import 'package:medical_app/screens/doctor/detail_doctor_order.dart';
import 'package:medical_app/utilities/http_service.dart';
import 'package:medical_app/utilities/medics.dart';
import 'package:provider/provider.dart';

class AvalibleOrderScreen extends StatefulWidget {
  @override
  _AvalibleOrderScreenState createState() => _AvalibleOrderScreenState();
}
final medics = MedicList.docSpeciality;
final HttpService httpService = HttpService();
enum list { ped, ter, sur, far, onk }

class _AvalibleOrderScreenState extends State<AvalibleOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final clients = Provider.of<UsersProvider>(context, listen: false);
    var _selection ='&specialization=${clients.doctor.specialty}';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Список заказов:"),
        ),
        body: FutureBuilder(
          future: httpService.getOrders(_selection),
          builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
            if (snapshot.hasData) {
              List<Order> orders = snapshot.data;
              return ListView(
                children: orders
                    .map(
                      (Order order) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          elevation: 5,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                color: Color.fromRGBO(228, 239, 243, 1.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(21.0),
                                      child: Wrap(
                                        children: <Widget>[
                                          Text(
                                            "Врач:",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            order.specialization,
                                            style: TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(21.0),
                                      child: Wrap(
                                        children: <Widget>[
                                          Text(
                                            "Адрес:",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            order.address,
                                            style: TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(21.0),
                                      child: Wrap(
                                        children: <Widget>[
                                          Text(
                                            "Дата и время:",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            DateFormat(
                                                    'dd.MM.yyyy hh:mm', 'en_US')
                                                .format(
                                                    DateTime.parse(order.date)),
                                            style: TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ButtonBar(
                                children: <Widget>[
                                  FlatButton(
                                    child: const Text(
                                      'Подробнее',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                DetailDoctorOrderScreen(
                                                    order: order))),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
