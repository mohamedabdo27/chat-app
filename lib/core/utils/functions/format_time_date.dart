import 'package:intl/intl.dart';

String formatDateTime(String date) {
  final DateTime dateTime = DateTime.parse(date);

  final DateTime inputDate =
      DateTime(dateTime.year, dateTime.month, dateTime.day);

  DateTime today = DateTime.now();
  DateTime yesterday = today.subtract(const Duration(days: 1));

  DateTime startOfToday = DateTime(today.year, today.month, today.day);
  DateTime startOfYesterday =
      DateTime(yesterday.year, yesterday.month, yesterday.day);

  if (inputDate.isAtSameMomentAs(startOfToday)) {
    return DateFormat("hh:mm a").format(dateTime.toLocal());
  } else if (inputDate.isAtSameMomentAs(startOfYesterday)) {
    return "Yesterday ${DateFormat("hh:mm a").format(dateTime)}";
  } else if (inputDate.isBefore(startOfYesterday)) {
    return DateFormat("dd/MM/yyyy hh:mm a").format(dateTime);
  } else {
    return "";
  }
}
