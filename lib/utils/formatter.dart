import 'package:intl/intl.dart';

class Formatter {
  String getCurrentDateWithFormat(String format) {
    return DateFormat(format).format(DateTime.now());
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy  HH:mm').format(dateTime);
  }

  String formatDateWeekday(DateTime dateTime) {
    return DateFormat('E, dd MMM yyyy').format(dateTime);
  }

  String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  String formatWeekday(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }

  String formatDateMonthYear(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }
}
