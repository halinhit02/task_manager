import 'package:flutter/src/material/time.dart';

class DateTimeHelper {
  static int getCurrentTimeMillis() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static int getCurrentDateMillis() {
    var now = DateTime.now();
    return DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
  }

  static int getDateFromTimeMillis(int timeMillis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timeMillis);
    return DateTime(dt.year, dt.month, dt.day).millisecondsSinceEpoch;
  }

  static int getDateTime(DateTime date) {
    return date.millisecondsSinceEpoch;
  }
}
