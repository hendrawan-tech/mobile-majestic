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

  Future<List<OrderModel>> getDataDone({String? user}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var response = await http.get(
        Uri.parse('${Config.baseUrl}/users/orders/done?user_id=$user'),
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

  Future<OrderModel> sendPayment({String? file, String? id}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Config.baseUrl}/users/orders/payment'),
    );

    request.files.add(
      await http.MultipartFile.fromPath('transfer', file!),
    );
    request.fields["id"] = id.toString();

    var res = await request.send().then(
          (result) => http.Response.fromStream(result).then(
            (response) {
              if (response.statusCode == 200) {
                // print(response.body);
                return response;
              } else {
                // print("Error during connection to server");
                print(response.body);
              }
            },
          ),
        );

    return OrderModel();

    // if (res.statusCode == 200) {
    //   var data = jsonDecode(res.body)['data'];
    //   OrderModel product = OrderModel.fromJson(data);
    //   return product;
    // } else {
    //   throw Exception("Failed Login");
    // }
  }
}
