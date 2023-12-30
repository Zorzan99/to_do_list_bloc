import 'package:flutter/material.dart';

class ScreenSize {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double percentWidth(BuildContext context, double percent) =>
      screenWidth(context) * percent;

  static double percentHeight(BuildContext context, double percent) =>
      screenHeight(context) * percent;
}
