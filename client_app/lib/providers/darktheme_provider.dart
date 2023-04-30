import 'package:client_app/sharedpreferences.dart';
import 'package:flutter/material.dart';

class DarkThemeProvider with ChangeNotifier {
  SettingSharedPreferences darkThemePreference = SettingSharedPreferences();
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setdarktheme(value);
    notifyListeners();
  }
}
