import 'package:flutter/cupertino.dart';
import 'package:majestic/models/order_model.dart';
import 'package:majestic/services/checkout_service.dart';

class CheckoutProvider with ChangeNotifier {
  OrderModel? _product;

  OrderModel? get product => _product;

  void setProduct(OrderModel product) {
    _product = product;
    notifyListeners();
  }

  Future<bool> order({
    String? postId,
    String? userId,
    String? paymentId,
    String? qty,
    String? total,
    String? date,
    String? status,
  }) async {
    try {
      OrderModel data = await CheckoutService().checkout(
        postId: postId,
        userId: userId,
        paymentId: paymentId,
        qty: qty,
        total: total,
        date: date,
        status: status,
      );
      _product = data;
      return true;
    } catch (e) {
      return false;
    }
  }
}
