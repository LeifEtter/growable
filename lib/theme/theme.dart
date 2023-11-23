import 'package:flutter/material.dart';
import 'package:growable/constants.dart';

class CustomTheme {
  GrowableColors growableColor = GrowableColors();

  ThemeData get theme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            background: GrowableColors.yellowGreen),
        useMaterial3: true,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.w600,
          ),
          displayMedium: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
