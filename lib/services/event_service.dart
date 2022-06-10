import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:majestic/config.dart';
import 'package:majestic/models/product_model.dart';

class EventService {
  Future<List<ProductModel>> getProduct({String? id}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var response = await http.get(
        Uri.parse('${Config.baseUrl}/events?item=15&id=$id'),
        headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Failed Service!');
    }
  }
}
