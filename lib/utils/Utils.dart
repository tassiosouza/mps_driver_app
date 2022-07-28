// ignore_for_file: depend_on_referenced_packages

import '../models/Client.dart';
import 'dart:convert';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:intl/intl.dart';

class Utils {
  static String getFormattedTimeFromString(String? timestamp) {
    TemporalDateTime time = TemporalDateTime.fromString(timestamp!);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        time.getDateTimeInUtc().microsecondsSinceEpoch);

    String timeFormatted = DateFormat('kk:mm').format(dateTime);
    return timeFormatted;
  }

  static String getFormattedTime(
      TemporalTimestamp? timestamp, bool withSuffix) {
    if (timestamp == null) return '-';
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp.toSeconds() * 1000);

    String timeFormatted =
        DateFormat(withSuffix ? 'kk:mm a' : 'kk:mm').format(dateTime);
    return timeFormatted;
  }

  static String getFormattedDistance(int? meters, bool abv) {
    if (meters == null) return '-';
    double miles = meters * 0.000621371192;
    String suffix = abv ? 'mi' : 'miles';
    String milesFormatted = '${miles.toString().split('.')[0]} $suffix';
    return milesFormatted;
  }

  static String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}h${twoDigitMinutes}m";
  }

  static String getFormattedDuration(int? seconds) {
    if (seconds == null) return '-';
    final duration = Duration(seconds: seconds);

    String milesFormatted = _printDuration(duration);
    return milesFormatted;
  }
}
