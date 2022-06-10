import 'package:flutter/cupertino.dart';
import 'package:majestic/models/payment_model.dart';
import 'package:majestic/services/payment_service.dart';

class PaymentProvider with ChangeNotifier {
  List<PaymentModel> _payments = [];
  List<PaymentModel> get payments => _payments;

  set payments(List<PaymentModel> payments) {
    _payments = payments;
    notifyListeners();
  }

  Future<void> getPayments() async {
    try {
      List<PaymentModel> payments = await PaymentService().getData();
      _payments = payments;
    } catch (e) {
      print(e);
    }
  }
}
