import 'package:flutter/material.dart';

class GlobalVariable {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static Orientation? orientation;
  static final backgroundcolor = Colors.grey[300];
  static final textFieldbackgroundcolor = Colors.grey[300];
  static final buttonsColors = Colors.deepPurple;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

class ApiURL {
  static const String apiURL = "0.0.0.0:4000";
  static const String signupAPI = "/api/auth/signup";
}
