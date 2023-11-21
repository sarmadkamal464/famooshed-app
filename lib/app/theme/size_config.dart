import 'package:flutter/material.dart';

class SizeConfig {
  late MediaQueryData _mediaQueryData;
  static double? deviceWidth;
  static double? deviceHeight;
  static bool? isDarkMode;
  static bool? isLightMode;
  static Orientation? orientation;
  static Brightness? brightness;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    deviceWidth = _mediaQueryData.size.width;
    deviceHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    brightness = _mediaQueryData.platformBrightness;

    isDarkMode = false;

    // isDarkMode = _mediaQueryData.platformBrightness == Brightness.dark;
    // isLightMode = _mediaQueryData.platformBrightness == Brightness.light;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  double? screenHeight = SizeConfig.deviceHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight!;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double? screenWidth = SizeConfig.deviceWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth!;
}

double getProportionalFontSize(int fontsize) {
  double finalFontSize = fontsize.toDouble();
  double? screenWidth = SizeConfig.deviceWidth;
  finalFontSize = (finalFontSize * screenWidth!) / 375.0;
  return finalFontSize;
}
