import 'package:flutter/cupertino.dart';
import 'package:majestic/models/auth_model.dart';
import 'package:majestic/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  AuthModel? _user;

  AuthModel? get user => _user;

  void setUser(AuthModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> login({String? email, String? password}) async {
    try {
      AuthModel data =
          await AuthService().login(email: email, password: password);
      _user = data;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register({String? name, String? email, String? password}) async {
    try {
      AuthModel data = await AuthService()
          .register(name: name, email: email, password: password);
      _user = data;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> update({
    String? name,
    String? id,
    String? phoneNumber,
    String? file,
  }) async {
    try {
      AuthModel data = await AuthService().update(
        name: name,
        file: file,
        id: id,
        phoneNumber: phoneNumber,
      );
      _user = data;
      return true;
    } catch (e) {
      return false;
    }
  }
}
