import 'package:flutter/material.dart';

class SizeConfig {
  static double screenWidth;
  static double screenHeight;
  static Orientation orientation;

  void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * SizeConfig.screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * SizeConfig.screenWidth;
}
