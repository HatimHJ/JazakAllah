import 'package:flutter/material.dart';

class ThemeManager {
  ThemeManager._();

  static ThemeData getAppTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: 'Barlow',
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFEBE64),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.0),
          ),
        ),
      ),
      // textTheme: const TextTheme(
      //   bodySmall: TextStyle(
      //     fontSize: 14,
      //     fontWeight: FontWeight.w500,
      //     color: Color.fromRGBO(16, 24, 40, 1),
      //   ),
      //   bodyMedium: TextStyle(
      //     fontSize: 16,
      //   ),
      //   titleLarge: TextStyle(
      //     fontSize: 24,
      //     fontFamily: 'lobster',
      //     fontWeight: FontWeights.regular,
      //     color: Color.fromRGBO(16, 24, 40, 1),
      //   ),
      //   titleMedium: TextStyle(
      //     fontSize: 20,
      //     fontWeight: FontWeights.regular,
      //     color: Color.fromRGBO(16, 24, 40, 1),
      //   ),
      //   titleSmall: TextStyle(
      //     fontSize: 18,
      //     fontWeight: FontWeights.regular,
      //     color: Color.fromRGBO(16, 24, 40, 1),
      //   ),
      // ),
    );
  }
}
