import 'dart:ui';

enum App_Colors {
  primary_color,
  alert_color
}

extension ColorsExtension on App_Colors {
  Color get value {
    switch(this) {
      case App_Colors.primary_color:
        return Color(0xFF3AB81A);
      case App_Colors.alert_color:
        return Color(0xFFA10505);
    }
  }
}