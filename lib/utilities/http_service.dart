import 'dart:convert';

import 'package:http/http.dart';
import 'package:medical_app/models/order.dart';

class HttpService {
  static final String urlApi = "http://medic.bw2api.ru/api/v1";

  Future<List<Order>> getOrders(String query) async {
    Response res = await get(urlApi + '/crud/order?_sort=date&status=New' + query);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Order> orders = body
          .map(
            (dynamic item) => Order.fromJson(item),
          )
          .toList();

      return orders;
    } else {
      throw 'Cant get orders.';
    }
  }
}
