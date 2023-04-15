import 'package:flutter/material.dart';

class SizeConfig{
  static MediaQueryData? _mediaQueryData;
  static double? defaultSize;
  static double? screenWidth;
  static double? screenHeight;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
    // On iPhone 11 the defaultSize = 10 almost
    // So if the screen size increases or decreases then the defaultSize also varies
    defaultSize = orientation == Orientation.landscape
        ? screenHeight! * 0.024
        : screenWidth! * 0.024;
  }
}