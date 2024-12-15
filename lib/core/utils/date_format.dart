import 'package:intl/intl.dart';

class DateFormatter {
  static String getDateFormatddMMMyyyy(DateTime date) {
    return DateFormat('dd MMM, yyyy', 'en_US').format(date);
  }
}
