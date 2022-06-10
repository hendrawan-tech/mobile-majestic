import 'package:flutter/material.dart';
import 'package:majestic/providers/payment_provider.dart';
import 'package:provider/provider.dart';
import 'package:majestic/providers/destination_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getPayment();
    super.initState();
  }

  getPayment() async {
    await Provider.of<PaymentProvider>(context, listen: false).getPayments();
    Navigator.pushNamed(context, '/signin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/banyuangi.png',
          height: 200.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
