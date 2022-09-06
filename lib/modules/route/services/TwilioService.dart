// ignore_for_file: depend_on_referenced_packages

import 'package:mps_driver_app/models/Driver.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'dart:developer';
import 'package:intl/intl.dart';

class TwilioSmsService {
  final Driver _currentDriver;
  TwilioSmsService(this._currentDriver);

  TwilioFlutter twilioFlutter = TwilioFlutter(
      accountSid: 'ACfcf134f0de9f85c19790e91e29cb6d63',
      authToken: '4335317aa987c70f6263b960ef453d2f',
      twilioNumber: '6193936481');

  String getFirstName(String name) {
    var result = '';
    if (name.contains(' ')) {
      var blankIndex = name.indexOf(' ');
      result = name.substring(0, blankIndex);
    } else {
      result = name;
    }
    return result;
  }

  void sendSms(String client_name, String clientPhone, int? client_eta) {
    log('calling send sms');
    String _printDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      return "${twoDigits(duration.inHours)}h${twoDigitMinutes}m"
          .replaceAll('00h', '');
    }

    String firstName = getFirstName(client_name);
    String eta = _printDuration(
        Duration(seconds: client_eta! + 600)); //Plus 10min for bags delivering
    String message = """Hello, $firstName"""
        """\nI am ${getFirstName(_currentDriver.name)} and I will be your driver today. I will be delivering your meals from Meal Prep Sunday San Diego. I want to inform you that your meals will be leaving our facilities soon and you can expect to receive them in $eta."""
        """\n\nIn case you won’t be home and it is needed further information to get into your building or gated community, please send a message to me at ${_currentDriver.phone} with the instructions. In case you need to talk to the customer service, please reply this message"""
        """\n\nThank you very much,"""
        """\n\n${getFirstName(_currentDriver.name)}""";
    twilioFlutter.sendSMS(
        toNumber: '+1$clientPhone', messageBody: message, messageMediaUrl: '');
  }

  void sendSmsWithPhoto(String phone, String url) {
    DateTime now = DateTime.now();
    String time = DateFormat.jm().format(now);
    String message =
        """🍱Your meals from Meal Prep Sunday San Diego have been successfully delivered to your doorstep at $time
"""
                """\n\n🏋🏽‍♀'Difficult roads often will lead to beautiful destinations'"""
                """\n\nIn case you won’t be home and it is needed further information to get into your building or gated community, please reply this text with the instructions."""
                """\n\nIf you have any inquiries, questions or problems, please contact us at info@mealprepsundaysandiego.com, please don’t text the driver."""
                """\n\n📌Your feedback means a lot to us.""" +
            """\n\n✌🏼Thank you for choosing us, and enjoy your meals!"""
                """\n\n💪🏼MPSSD Team""";
    twilioFlutter.sendSMS(
        toNumber: '+1$phone', messageBody: message, messageMediaUrl: url);
  }
}
