import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class LoginSharedPreferences {
  static const login = "token";
  static const useremail = "email";
  setloginToken(String val, String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(login, val);
    pref.setString(useremail, email);
  }

  Future<String> getloginToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(login) ?? "Invalid Token";

    return token;
  }

  Future<String> getemail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String email = pref.getString(useremail) ?? "Invalid";

    return email;
  }

  clearloginToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(login);
  }
}

class SettingSharedPreferences {
  static const mode = "theme_mode";
  static const location = "location";
  setdarktheme(bool val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(mode, val);
  }

  Future<bool> getTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool theme = pref.getBool(mode) ?? false;
    return theme;
  }

  // setlocation(Position val) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString(location, val.toString());
  // }

  // Future<String> getlocation() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String Position =pref.getString(val.toString())
  // }
}
