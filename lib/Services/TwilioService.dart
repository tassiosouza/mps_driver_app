import 'package:flutter/cupertino.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'dart:developer';

class TwilioSmsService {
  TwilioFlutter twilioFlutter = TwilioFlutter(
      accountSid: 'ACfcf134f0de9f85c19790e91e29cb6d63',
      authToken: '4335317aa987c70f6263b960ef453d2f',
      twilioNumber: '6193936481');

  void sendSms(String client_name, int client_eta) {
    log('calling send sms');
    String _printDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      return "${twoDigits(duration.inHours)}h${twoDigitMinutes}m"
          .replaceAll('00h', '');
    }

    int spaceIndex = client_name.indexOf(' ');
    String firstName = client_name.substring(0, spaceIndex);
    String eta = _printDuration(Duration(seconds: client_eta));
    String message = """Hello, $firstName""" +
        """\nI am Tassio and I will be your driver today. I will be delivering your meals from Meal Prep Sunday San Diego. I want to inform you that your meals will be leaving our facilities soon and you can expect to receive them in $eta.""" +
        """\n\nIn case you won’t be home and it is needed further information to get into your building or gated community, please reply this text with the instructions.""" +
        """\n\nThank you very much,""" +
        """\n\nTassio""";
    twilioFlutter.sendSMS(
        toNumber: '+16197634382', messageBody: message, messageMediaUrl: '');
  }

  void sendSmsWithPhoto(String client_name, int client_eta, String url) {
    String message =
        """🍱Your meals from Meal Prep Sunday San Diego have been successfully delivered to your doorstep at 7:23pm
""" +
            """\n\n🏋🏽‍♀'Difficult roads often will lead to beautiful destinations'""" +
            """\n\nIn case you won’t be home and it is needed further information to get into your building or gated community, please reply this text with the instructions.""" +
            """\n\nIf you have any inquiries, questions or problems, please contact us at info@mealprepsundaysandiego.com, please don’t text the driver.""" +
            """\n\n📌Your feedback means a lot to us.""" +
            """\n\n✌🏼Thank you for choosing us, and enjoy your meals!"""
                """\n\n💪🏼MPSSD Team""";
    twilioFlutter.sendSMS(
        toNumber: '+16197634382', messageBody: message, messageMediaUrl: url);
  }
}
