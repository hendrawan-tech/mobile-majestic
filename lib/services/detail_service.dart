import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:majestic/config.dart';
import 'package:majestic/models/product_model.dart';

class DetailService {
  Future<ProductModel> getData({String? id, String? user}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var response = await http.get(
        Uri.parse('${Config.baseUrl}/detail/$id&?id=$user'),
        headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      ProductModel product = ProductModel.fromJson(data);
      return product;
    } else {
      throw Exception("Failed Login");
    }
  }

  Future<ProductModel> likes({String? postId, String? userId}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var body = jsonEncode({
      'post_id': postId,
      'user_id': userId,
    });

    var response = await http.post(Uri.parse('${Config.baseUrl}/users/likes'),
        headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      ProductModel product = ProductModel.fromJson(data);
      return product;
    } else {
      throw Exception("Failed Login");
    }
  }

  Future<ProductModel> comments({
    String? postId,
    String? userId,
    String? comment,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var body = jsonEncode({
      'destination_id': postId,
      'user_id': userId,
      'comment': comment,
    });

    var response = await http.post(
      Uri.parse('${Config.baseUrl}/users/comment'),
      headers: headers,
      body: body,
    );

    print(body);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      ProductModel product = ProductModel.fromJson(data);
      return product;
    } else {
      throw Exception("Failed Login");
    }
  }
}
