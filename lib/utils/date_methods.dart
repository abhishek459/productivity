import 'package:intl/intl.dart';

class DateMethods {
  static String dateFormatter(DateTime dateTime) {
    int differenceInMinutes = DateTime.now().difference(dateTime).inMinutes;
    int differenceInDays = DateTime.now().difference(dateTime).inDays;
    if (differenceInMinutes < 1) {
      return 'Few seconds ago';
    } else if (differenceInMinutes == 1) {
      return '1 minute ago';
    } else if (differenceInMinutes < 60 &&
        DateTime.now().hour == dateTime.hour) {
      return '$differenceInMinutes minutes ago';
    } else if (differenceInDays < 1 && DateTime.now().day == dateTime.day) {
      return 'Today, ${DateFormat('h:mm a').format(dateTime)}';
    } else if (differenceInDays < 1) {
      return 'Yesterday, ${DateFormat('h:mm a').format(dateTime)}';
    } else if (differenceInDays < 7) {
      return DateFormat('EEEE, h:mm a').format(dateTime);
    } else {
      return DateFormat('d-MMM-yyyy').format(dateTime);
    }
  }

  static String today() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }
}
