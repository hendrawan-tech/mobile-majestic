import 'package:flutter/material.dart';
import 'package:majestic/pages/detail_page.dart';
import 'package:majestic/pages/home_page.dart';
import 'package:majestic/pages/order_page.dart';
import 'package:majestic/pages/payment_page.dart';
import 'package:majestic/pages/profile_page.dart';
import 'package:majestic/pages/signin_page.dart';
import 'package:majestic/pages/signup_page.dart';
import 'package:majestic/pages/splash_page.dart';
import 'package:majestic/pages/update_page.dart';
import 'package:majestic/providers/auth_provider.dart';
import 'package:majestic/providers/checkout_provider.dart';
import 'package:majestic/providers/destination_provider.dart';
import 'package:majestic/providers/detail_provider.dart';
import 'package:majestic/providers/event_provider.dart';
import 'package:majestic/providers/order_provider.dart';
import 'package:majestic/providers/payment_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DestinationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EventProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckoutProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Majestic majestic',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/signin': (context) => const SigninPage(),
          '/signup': (context) => const SignupPage(),
          '/home': (context) => const HomePage(),
          '/profile': (context) => const ProfilePage(),
          '/detail': (context) => DetailPage(),
          '/update-profile': (context) => const UpdatePage(),
          '/payment': (context) => const PaymentPage(),
          '/order': (context) => const OrderPage(),
        },
      ),
    );
  }
}
