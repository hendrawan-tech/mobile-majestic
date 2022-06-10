import 'package:flutter/cupertino.dart';
import 'package:majestic/models/order_model.dart';
import 'package:majestic/services/order_service.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _products = [];
  List<OrderModel> get products => _products;

  set products(List<OrderModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts({String? id}) async {
    try {
      List<OrderModel> products = await OrderService().getData(user: id);
      _products = products;
    } catch (e) {
      print(e);
    }
  }
}
