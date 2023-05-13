import 'dart:developer';
import 'dart:io';

import 'package:client_app/features/homepage/services/userServices.dart';
import 'package:client_app/modal/user_modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    name: '',
    email: '',
    userId: '',
    usertoken: '',
    address: '',
    contactno: '',
    dob: '',
    avatar: '',
  );
  User get user => _user;
  bool setUser = false;
  bool imageChanged = false;
  bool getUser = true;
  Future<void> setUserDetails(
      String name, String dob, String contact, String address) async {
    try {
      final http.Response response =
          (await UserServices.udpateprofile(name, dob, contact, address));
      if (response.statusCode == 200) {
        setUser = true;
        await getUserDetails(contact);
        notifyListeners();
      } else {
        throw Exception('Failed to post job');
      }
    } catch (e) {
      // Handle the error here, for example by showing a snackbar
      log(e.toString());
    }
  }

  Future<void> getUserDetails(String email) async {
    try {
      final http.Response response = (await UserServices.getProfile(email));
      if (response.statusCode == 200) {
        _user = User.userResponseJson(response.body);
        getUser = true;
        notifyListeners();
      } else {
        throw Exception('Failed to post job');
      }
    } catch (e) {
      // Handle the error here, for example by showing a snackbar
      log(e.toString());
    }
  }

  Future<void> changeImage(String contact, File imagefile) async {
    try {
      final http.BaseResponse response =
          (await UserServices.changeImage(contact, imagefile));
      if (response.statusCode == 200) {
        await getUserDetails(contact);
        imageChanged = true;
        notifyListeners();
      } else {
        throw Exception('Failed to post job');
      }
    } catch (e) {
      // Handle the error here, for example by showing a snackbar
      log(e.toString());
    }
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
      avatar: '',
    );
  }
}
