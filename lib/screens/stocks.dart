import 'package:flutter/material.dart';

class StocksPage extends StatefulWidget {
  @override
  _StocksPageState createState() => _StocksPageState();
}

Widget _buildStocksCard() {
  return Stack(
    children: <Widget>[
      Container(
          height: 250.0,
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          child: Image.network(
              "https://raw.githubusercontent.com/flutter/website/master/examples/layout/lakes/step5/images/lake.jpg",
              fit: BoxFit.cover)),
    ],
  );
}

class _StocksPageState extends State<StocksPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildStocksCard(),
        _buildStocksCard(),
        _buildStocksCard(),
        _buildStocksCard(),
      ],
    );
  }
}
