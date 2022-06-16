import 'dart:ui';

enum App_Colors {
  primary_color,
  alert_color,
  grey_dark,
  grey_light,
  white_background,
  black_text,
  grey_text,
  grey_background
}

extension ColorsExtension on App_Colors {
  Color get value {
    switch(this) {
      case App_Colors.primary_color:
        return Color(0xFF3AB81A);
      case App_Colors.alert_color:
        return Color(0xFFA10505);
      case App_Colors.grey_dark:
        return Color(0xFFC4C4C4);
      case App_Colors.grey_light:
        return Color(0xFFE6E6E6);
      case App_Colors.white_background:
        return Color(0xFFFAFAFA);
      case App_Colors.black_text:
        return Color(0xFF363636);
      case App_Colors.grey_text:
        return Color(0xFF878787);
      case App_Colors.grey_background:
        return Color(0xFFF4F4F4);
    }
  }
}