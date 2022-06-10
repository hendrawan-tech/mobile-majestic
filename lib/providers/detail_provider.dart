import 'package:flutter/cupertino.dart';
import 'package:majestic/models/product_model.dart';
import 'package:majestic/services/detail_service.dart';

class DetailProvider with ChangeNotifier {
  ProductModel? _product;

  ProductModel? get product => _product;

  void setProduct(ProductModel product) {
    _product = product;
    notifyListeners();
  }

  Future<bool> detail({String? id, String? user}) async {
    try {
      ProductModel data = await DetailService().getData(id: id, user: user);
      _product = data;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> like({String? id, String? post}) async {
    try {
      ProductModel data = await DetailService().likes(postId: post, userId: id);
      _product = data;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> comment({String? id, String? post, String? comment}) async {
    try {
      ProductModel data = await DetailService()
          .comments(postId: post, userId: id, comment: comment);
      _product = data;
      return true;
    } catch (e) {
      return false;
    }
  }
}
