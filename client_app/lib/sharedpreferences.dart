import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class LoginSharedPreferences {
  static const login = "token";
  setloginToken(String val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(login, val);
  }

  Future<String> getloginToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(login) ?? "Invalid Token";
    return token;
  }

  clearloginToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(login);
  }
}

class SettingSharedPreferences {
  static const mode = "theme_mode";
  setdarktheme(bool val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(mode, val);
  }

  Future<bool> getTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool theme = pref.getBool(mode) ?? false;
    return theme;
  }
}
