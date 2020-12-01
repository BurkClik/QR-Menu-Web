import 'package:flutter/material.dart';
import 'package:qr_web/theme/constants.dart';

ThemeData theme() {
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: kPrimaryColor,
    floatingActionButtonTheme: floatingActionButtonThemeData(),
    primaryColor: Colors.black,
  );
}

FloatingActionButtonThemeData floatingActionButtonThemeData() {
  return FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
  );
}
