import 'package:intl/intl.dart';

class DateMethods {
  static String dateFormatter(DateTime dateTime) {
    int differenceInMinutes = DateTime.now().difference(dateTime).inMinutes;
    int differenceInDays = DateTime.now().difference(dateTime).inDays;
    if (differenceInMinutes < 1) {
      return 'few seconds ago';
    } else if (differenceInMinutes == 1) {
      return '1 minute ago';
    } else if (differenceInMinutes < 60) {
      return '$differenceInMinutes minutes ago';
    } else if (differenceInDays < 1) {
      return DateFormat('h:mm a').format(dateTime);
    } else if (differenceInDays < 7) {
      return DateFormat('EEE - h:mm a').format(dateTime);
    } else {
      return DateFormat('d-MMM-yyyy').format(dateTime);
    }
  }

  static String today() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }
}
