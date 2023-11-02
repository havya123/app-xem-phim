import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData themeApp = ThemeData(
    scaffoldBackgroundColor: const Color(0xff242A32),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontWeight: FontWeight.w500, color: Colors.white, fontSize: 23),
      labelMedium: TextStyle(
        fontSize: 20,
        color: Color(0xff67686D),
      ),
      titleMedium: TextStyle(fontSize: 15, color: Colors.white),
      titleSmall: TextStyle(fontSize: 20, color: Colors.blue),
    ),
  );
}
