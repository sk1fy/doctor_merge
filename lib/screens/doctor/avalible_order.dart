import 'package:flutter/material.dart';
import 'package:medical_app/models/data_providers.dart';
import 'package:medical_app/screens/doctor/detail_doctor_order.dart';
import 'package:provider/provider.dart';

class AvalibleOrderScreen extends StatefulWidget {
  @override
  _AvalibleOrderScreenState createState() => _AvalibleOrderScreenState();
}

class _AvalibleOrderScreenState extends State<AvalibleOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Список доступных заказов:"),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, position) {
            return Consumer<OrderProvider>(
              builder: (_, order, child) => Padding(
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
                                    order.order.specialization == null ? 'Врач не выбран' : order.order.specialization,
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
                                    order.order.address,
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
                                    order.order.date,
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
                                        DetailDoctorOrderScreen())),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
