// / Calculate duration from two TimeOfDay values`
import 'package:flutter/material.dart';
import 'package:solid_weight_calculator/src/models/functions.dart';

class TimeToDuration {
  static Duration durationAsTime(TimeOfDay startTime, TimeOfDay endTime) {
    DateTime now = DateTime.now().toUtc();
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1)).toUtc();
    final startDateTime = DateTime(
        now.year, now.month, now.day, startTime.hour, startTime.minute);

    if (endTime == const TimeOfDay(hour: 00, minute: 00)) {
      final endDateTime = DateTime(tomorrow.year, tomorrow.month, tomorrow.day,
          endTime.hour, endTime.minute);
      Duration difference = endDateTime.difference(startDateTime);
      return difference;
    } else {
      final endDateTime =
          DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);
      Duration difference = endDateTime.difference(startDateTime);
      return difference;
    }
  }

  static String durationAsString(TimeOfDay startTime, TimeOfDay endTime) {
    return formattedDuration(durationAsTime(startTime, endTime));
  }
}
