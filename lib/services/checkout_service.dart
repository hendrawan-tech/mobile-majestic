import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:majestic/config.dart';
import 'package:majestic/models/order_model.dart';

class CheckoutService {
  Future<OrderModel> checkout({
    String? postId,
    String? userId,
    String? paymentId,
    String? qty,
    String? total,
    String? date,
    String? status,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var body = jsonEncode({
      'product_id': postId,
      'user_id': userId,
      'payment_id': paymentId,
      'quantity': qty,
      'total': total,
      'date': date,
      'status': status,
    });

    print(body);

    var response = await http.post(Uri.parse('${Config.baseUrl}/users/orders'),
        headers: headers, body: body);

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print(data);
      OrderModel product = OrderModel.fromJson(data);
      return product;
    } else {
      throw Exception("Failed Login");
    }
  }
}
