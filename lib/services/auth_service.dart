import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:majestic/config.dart';
import 'package:majestic/models/auth_model.dart';

class AuthService {
  Future<AuthModel> login({String? email, String? password}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    print({"auth", body});

    var response = await http.post(Uri.parse('${Config.baseUrl}/login'),
        headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      AuthModel user = AuthModel.fromJson(data['user']);
      user.token = 'Bearer' + data['token'];
      user.profile = data['profile'];
      print({"asdads", user});
      return user;
    } else {
      throw Exception("Failed Login");
    }
  }

  Future<AuthModel> register({String? name, String? email, String? password}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var body = jsonEncode({
      'name' : name,
      'email': email,
      'password': password,
    });

    print({"auth", body});

    var response = await http.post(Uri.parse('${Config.baseUrl}/users'),
        headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      AuthModel user = AuthModel.fromJson(data['user']);
      user.token = 'Bearer' + data['token'];
      user.profile = data['profile'];
      // print({"asdads", user});
      return user;
    } else {
      throw Exception("Failed Login");
    }
  }
}
