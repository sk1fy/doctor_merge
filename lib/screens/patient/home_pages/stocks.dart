import 'package:flutter/material.dart';
import 'package:medical_app/models/data_providers.dart';
import 'package:provider/provider.dart';



class StocksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stock = Provider.of<StockProvider>(context);
    return Consumer<StockProvider>(
      builder: (context, stock, child) => ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Stack(
            children: <Widget>[
              Container(
                  height: 250.0,
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child:
                      Image.network(stock.stock.imageUrl, fit: BoxFit.cover)),
            ],
          );
        },
      ),
    );
  }
}
