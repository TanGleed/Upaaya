import 'package:client_app/modal/user_modal.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    name: '',
    email: '',
    userId: '',
    usertoken: '',
    address: '',
    contactno: '',
    dob: '',
  );
  User get user => _user;
  void setLoginDetails(String jsonData) {
    _user = User.userResponseJson(jsonData);
    notifyListeners();
  }

  void logout() {
    _user = User(
      name: '',
      email: '',
      userId: '',
      usertoken: '',
      address: '',
      contactno: '',
      dob: '',
    );
  }
}
