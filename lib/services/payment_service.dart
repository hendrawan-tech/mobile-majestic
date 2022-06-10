import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:majestic/config.dart';
import 'package:majestic/models/payment_model.dart';

class PaymentService {
  Future<List<PaymentModel>> getData() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var response = await http.get(Uri.parse('${Config.baseUrl}/payment?item=3'),
        headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<PaymentModel> payments = [];

      for (var item in data) {
        payments.add(PaymentModel.fromJson(item));
      }

      return payments;
    } else {
      throw Exception('Failed Service!');
    }
  }
}
