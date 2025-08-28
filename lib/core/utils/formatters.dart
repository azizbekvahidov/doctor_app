import 'package:intl/intl.dart';

class DateFormatter {
  static birthday(DateTime date) {
    return DateFormat("dd-MM-yyyy").format(date);
  }
}
