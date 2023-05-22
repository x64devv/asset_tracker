import 'package:flutter/material.dart';

const Color bluishClr = Colors.blue;
const Color primaryColor = Color(0xFFFFB6C1);
const Color yellowishClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);
const Color textColor = Color(0xFF1e1e1e);

class Themes{

  static final lightTheme = ThemeData(
      primarySwatch: Colors.pink,
      primaryColor: primaryColor,
      brightness: Brightness.light
  );

  static final darkTheme = ThemeData(
      primaryColor: darkGreyClr,
      brightness: Brightness.dark
  );

}