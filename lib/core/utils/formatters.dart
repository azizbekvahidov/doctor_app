import 'package:intl/intl.dart';

class DateFormatter {
  static birthday(DateTime date) {
    return DateFormat("dd-MM-yyyy").format(date);
  }
}

class PriceFormatter {
  static String format(double price) {
    final formatter = NumberFormat('#,###');
    return "${formatter.format(price).replaceAll(',', ' ')} UZS";
  }
}
