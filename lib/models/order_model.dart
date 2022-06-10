import 'package:majestic/models/auth_model.dart';
import 'package:majestic/models/payment_model.dart';
import 'package:majestic/models/product_model.dart';

class OrderModel {
  int? id;
  String? code;
  int? productId;
  int? userId;
  int? paymentId;
  String? quantity;
  String? total;
  String? date;
  String? status;
  String? createdAt;
  String? updatedAt;
  AuthModel? user;
  PaymentModel? payment;
  ProductModel? product;

  OrderModel({
    this.id,
    this.code,
    this.productId,
    this.userId,
    this.paymentId,
    this.quantity,
    this.total,
    this.date,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.payment,
    this.product,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    productId = json['product_id'];
    userId = json['user_id'];
    paymentId = json['payment_id'];
    quantity = json['quantity'];
    total = json['total'];
    date = json['date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = AuthModel.fromJson(json['user']);
    payment = PaymentModel.fromJson(json['payment']);
    product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['product_id'] = productId;
    data['user_id'] = userId;
    data['payment_id'] = paymentId;
    data['quantity'] = quantity;
    data['total'] = total;
    data['date'] = date;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user'] = user?.toJson();
    data['payment'] = payment?.toJson();
    data['product'] = product?.toJson();
    return data;
  }
}
