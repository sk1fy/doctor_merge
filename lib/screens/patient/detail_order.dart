import 'package:flutter/material.dart';
import 'package:medical_app/models/data_providers.dart';
import 'package:provider/provider.dart';

class DetailOrderScreen extends StatefulWidget {
  @override
  _DetailOrderScreenState createState() => _DetailOrderScreenState();
}

Widget _buildMessageFrom() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(10),
        width: 250,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color.fromRGBO(228, 239, 243, 1.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                  "Здравсвуйте, у меня проблемы с моей бонусной картой, не могу добавить её в список. Пишет, что данный номер карты не верен."),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[Text("12.04.20 16:45")],
              ),
            )
          ],
        ),
      ),
    ],
  );
}

Widget _buildMessageTo() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(10),
        width: 250,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color.fromRGBO(228, 239, 243, 1.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                  "Здравсвуйте, у меня проблемы с моей бонусной картой, не могу добавить её в список. Пишет, что данный номер карты не верен."),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text("12.04.20 16:45")],
              ),
            )
          ],
        ),
      ),
    ],
  );
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Заказ 1231234112"),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Consumer<OrderProvider>(
                      builder: (_, order, child) => Column(
                        children: <Widget>[
                          _buildMessageTo(),
                          _buildMessageFrom(),
                          _buildMessageTo(),
                          _buildMessageFrom(),
                          _buildMessageFrom()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          maxLength: 200,
                          decoration: InputDecoration.collapsed(
                              hintText: "Отправить сообщение"),
                          onChanged: (String text) => null,
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () => print("Send Message")),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
