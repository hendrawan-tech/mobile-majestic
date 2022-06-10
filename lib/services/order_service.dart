import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:majestic/config.dart';
import 'package:majestic/models/order_model.dart';

class OrderService {
  Future<List<OrderModel>> getData({String? user}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var response = await http.get(
        Uri.parse('${Config.baseUrl}/users/orders?user_id=$user'),
        headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<OrderModel> products = [];
      for (var item in data) {
        products.add(OrderModel.fromJson(item));
      }
      return products;
    } else {
      throw Exception("Failed Login");
    }
  }
}
