import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/const_imports.dart';

class DateTimeHelper {
  static String getFormattedTimeFor({required Duration duration}) {
    if (duration.inHours >= 1) return formatByHours(duration);
    if (duration.inMinutes >= 1) return formatByMinutes(duration);

    return formatBySeconds(duration);
  }

  static String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  static DateTime? getDateTimeFrom({
    required String text,
    bool isToLocal = true,
  }) {
    if (isToLocal) {
      return DateTime.tryParse(text)?.toLocal();
    }
    return DateTime.tryParse(text);
  }

  static DateTime getDateTimeFromTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }

  static String getStringFrom({
    required DateTime dateTime,
    String format = DtFormatConsts.hhmm,
    bool isToLocal = true,
  }) {
    final formatter = DateFormat(format);
    if (isToLocal) {
      return formatter.format(dateTime.toLocal());
    }
    return formatter.format(dateTime);
  }

  static String getStringFromTimeOfDay(
    TimeOfDay timeOfDay, {
    String format = DtFormatConsts.hhmm,
    bool isToLocal = true,
  }) {
    final dateTime = getDateTimeFromTimeOfDay(timeOfDay);
    final formatter = DateFormat(format);
    if (isToLocal) {
      return formatter.format(dateTime.toLocal());
    }
    return formatter.format(dateTime);
  }

  static String getStringFromDateTimeString(
    dateTimeString, {
    String returnFormat = DtFormatConsts.hhmm,
    bool isToLocal = true,
  }) {
    DateTime? dt;

    if (isToLocal) {
      dt = DateTime.tryParse(dateTimeString)?.toLocal();
    } else {
      dt = DateTime.tryParse(dateTimeString);
    }
    if (dt != null) {
      final formatter = DateFormat(returnFormat);
      return formatter.format(dt);
    }
    return '';
  }

  static String formatBySeconds(Duration duration) =>
      twoDigits(duration.inSeconds.remainder(60));

  static String formatByMinutes(Duration duration) {
    var twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return '$twoDigitMinutes:${formatBySeconds(duration)}';
  }

  static String formatByHours(Duration duration) {
    return '${twoDigits(duration.inHours)}:${formatByMinutes(duration)}';
  }
}