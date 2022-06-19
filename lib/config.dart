import 'package:intl/intl.dart';

class Config {
  static const String baseUrl = 'https://majestic-banyuangi.ws-tif.com/api/api';
  static const String url = 'https://majestic-banyuangi.ws-tif.com/api/images';

  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
