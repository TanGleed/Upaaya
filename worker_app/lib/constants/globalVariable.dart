import 'package:flutter/material.dart';

//Screen Config
class GlobalVariable {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static Orientation? orientation;
  static final backgroundcolor = Colors.grey[300];
  static final textFieldbackgroundcolor = Colors.grey[300];
  static final buttonsColors = Colors.deepPurple;
  static final String appName = 'Upaaya';
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

  double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = GlobalVariable.screenWidth;
    // 375 is the layout width that designer use
    return (inputWidth / 375.0) * screenWidth;
  }

  double getProportionateScreenHeight(double inputHeight) {
    double screenHeight = GlobalVariable.screenHeight;
    // 812 is the layout height that designer use
    return (inputHeight / 812.0) * screenHeight;
  }
}

//API URLS
class ApiURL {
  static const String appName = "Upaaya";
  static const String apiURL = "192.168.137.113:5000";
  static const String imageURL = "http://192.168.137.113:5000";
  static const String signupAPI = "/api/v1/auth/register";
  static const String uniqueemailAPI = "/api/v1/auth/uniqueemail";
  static const String sendOTPAPI = "api/v1/auth/sendOTP";
  static const String verifyOTPAPI = "api/v1/auth/verifyOTP";
  static const String loginAPI = "api/v1/auth/login";
  static const String getJobsAPI = "api/v1/jobs";
  static const String resetpassAPI = "api/v1/auth/resetpassword";
  static const String categoryAPI = "api/v1/category";
  static const int pageSize = 10;
  static const String google_api_key =
      "AIzaSyD6zY45eABG5e6b6k7Mk0q5eP3UCLqFR3k";
}

//Keyboard
class KeyboardUtil {
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
