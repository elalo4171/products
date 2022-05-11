import 'package:flutter/material.dart';
import 'package:products/Theme/colors.dart';

class CustomTheme {
  static ThemeData themeLigth = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: ColorsCustom.primary,
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarTextStyle: TextStyle(
          color: Colors.black,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        )),
  );
}
