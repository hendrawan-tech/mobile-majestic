import 'package:intl/intl.dart';

class Config {
  static const String baseUrl = 'https://f43e-180-253-165-63.ap.ngrok.io/api';
  static const String url = 'https://f43e-180-253-165-63.ap.ngrok.io';

  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
