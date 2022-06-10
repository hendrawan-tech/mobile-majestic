import 'package:flutter/cupertino.dart';
import 'package:majestic/models/product_model.dart';
import 'package:majestic/services/destination_service.dart';

class DestinationProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts({String? id}) async {
    try {
      List<ProductModel> products =
          await DestinationService().getProduct(id: id);
      _products = products;
    } catch (e) {
      print(e);
    }
  }
}
