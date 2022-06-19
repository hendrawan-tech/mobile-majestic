import 'package:flutter/cupertino.dart';
import 'package:majestic/models/order_model.dart';
import 'package:majestic/services/order_service.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _products = [];
  List<OrderModel> _productsDone = [];
  List<OrderModel> get products => _products;
  List<OrderModel> get productsDone => _productsDone;

  set products(List<OrderModel> products) {
    _products = products;
    notifyListeners();
  }

  set productsDone(List<OrderModel> products) {
    _productsDone = products;
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

  Future<void> getProductsDone({String? id}) async {
    try {
      List<OrderModel> products = await OrderService().getDataDone(user: id);
      _productsDone = products;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> payment({String? file, String? id}) async {
    try {
      OrderModel product = await OrderService().sendPayment(file: file, id: id);
      _products.add(product);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
