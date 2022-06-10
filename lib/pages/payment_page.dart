import 'package:flutter/material.dart';
import 'package:majestic/models/auth_model.dart';
import 'package:majestic/providers/auth_provider.dart';
import 'package:majestic/providers/checkout_provider.dart';
import 'package:majestic/providers/order_provider.dart';
import 'package:majestic/providers/payment_provider.dart';
import 'package:majestic/widgets/card_payment.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  final String? date;
  final String? qty;
  final String? total;
  final String? post;

  const PaymentPage({
    Key? key,
    this.date,
    this.qty,
    this.total,
    this.post,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    PaymentProvider paymentProvider = Provider.of<PaymentProvider>(context);
    CheckoutProvider checkoutProvider = Provider.of<CheckoutProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AuthModel? user = authProvider.user;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            extendedSizeConstraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width * .9,
              height: 48,
            ),
            backgroundColor: const Color(0xFF73C993),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: FloatingActionButton.extended(
          onPressed: () async {
            if (selected == 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Select Payment",
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.redAccent,
                ),
              );
            } else {
              if (await checkoutProvider.order(
                postId: widget.post,
                date: widget.date,
                qty: widget.qty,
                paymentId: selected.toString(),
                total: widget.total,
                userId: user!.id.toString(),
                status: 'Menunggu Pembayaran',
              )) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Order Success",
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                await Provider.of<OrderProvider>(context, listen: false)
                    .getProducts(
                  id: authProvider.user!.id.toString(),
                );
                Navigator.pushReplacementNamed(context, '/order');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Failed Order",
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
            }
          },
          label: const Text("Beli Sekarang"),
        ),
      ),
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text("Pilih Pembayaran"),
        backgroundColor: const Color(0xFF73C993),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 15),
        itemCount: paymentProvider.payments.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => setState(() {
              selected = paymentProvider.payments[index].id!;
            }),
            child: CardPayment(paymentProvider.payments[index], selected),
          );
        },
      ),
    );
  }
}
