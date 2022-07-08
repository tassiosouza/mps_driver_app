import 'package:flutter/material.dart';

class CustomTheme{
  // light theme
  final customLightTheme = ThemeData(
    // app's colors scheme and brightness
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      primarySwatch: Colors.green,
    ),
    // tab bar indicator color
    indicatorColor: Colors.green,
    textTheme: const TextTheme(
      // text theme of the header on each step
      bodyText1: TextStyle(fontFamily: 'Poppins'),
      bodyText2: TextStyle(fontFamily: 'Poppins'),
      headline6: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 24, fontFamily: 'Poppins'),
    ),
    // theme of the form fields for each step
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: const TextStyle(fontFamily: 'Poppins'),
      labelStyle: const TextStyle(fontFamily: 'Poppins'),
      hintStyle: const TextStyle(fontFamily: 'Poppins'),
      helperStyle: const TextStyle(fontFamily: 'Poppins'),
      contentPadding: const EdgeInsets.all(16),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey[200],
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    // theme of the primary button for each step
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(fontFamily: 'Poppins')),
        padding:
        MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),
  );
}