import 'package:intl/intl.dart';

class Formatter {

  static String formatPrice(int price) {
    final numberFormat = NumberFormat("#,##,###");
    return numberFormat.format(price);
  }

}