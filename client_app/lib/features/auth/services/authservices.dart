// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:client_app/sharedpreferences.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:client_app/constants/global_variable.dart';
import 'package:client_app/features/auth/services/authmodel.dart';
import 'package:client_app/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static var client = http.Client();
  //registers user
  static Future<bool> register(RegisterModal modal) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(ApiURL.apiURL, ApiURL.signupAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "name": modal.name.text,
          "email": modal.email.text,
          "password": modal.confirmpassword.text,
        },
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //check unique email
  static Future<bool> uniqueEmail(RegisterModal modal) async {
    Map<String, String> requestheaders = {'Content-Type': 'application/json'};
    var url = Uri.http(ApiURL.apiURL, ApiURL.uniqueemailAPI);
    var response = await client.post(url,
        headers: requestheaders,
        body: jsonEncode({
          "name": modal.name.text,
          "email": modal.email.text,
          "password": modal.confirmpassword.text
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //send otp
  static Future<bool> sendotp(RegisterModal modal) async {
    Map<String, String> requestheaders = {'Content-Type': 'application/json'};
    var url = Uri.http(ApiURL.apiURL, ApiURL.sendOTPAPI);
    var response = await client.post(url,
        headers: requestheaders,
        body: jsonEncode({
          "email": modal.email.text,
        }));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //verify otp
  static Future<String> verifyotp(RegisterModal modal, String pin) async {
    Map<String, String> requestheaders = {'content-type': 'application/json'};
    var url = Uri.http(ApiURL.apiURL, ApiURL.verifyOTPAPI);
    var response = await client.post(url,
        headers: requestheaders,
        body: jsonEncode({
          "email": modal.email.text,
          "otp": pin,
        }));
    if (response.statusCode == 200) {
      return "Success";
    } else if (response.statusCode == 409) {
      return "Invalid OTP";
    } else if (response.statusCode == 410) {
      return "OTP Expired";
    } else {
      return "Error";
    }
  }

  //login
  static Future<String> login(
    TextEditingController email,
    TextEditingController password,
    BuildContext context,
  ) async {
    Map<String, String> requestheaders = {'content-type': 'application/json'};
    var url = Uri.http(ApiURL.apiURL, ApiURL.loginAPI);
    var response = await client.post(url,
        headers: requestheaders,
        body: jsonEncode({
          "email": email.text,
          "password": password.text,
        }));

    if (response.statusCode == 200) {
      final user = jsonDecode(response.body);
      Provider.of<UserProvider>(context, listen: false)
          .setLoginDetails(response.body);
      LoginSharedPreferences().setloginToken(user['data']['usertoken']);
      return "Success";
    } else if (response.statusCode == 404) {
      return "Email Not Registered";
    } else if (response.statusCode == 401) {
      return "Invalid Password";
    } else {
      return "Error";
    }
  }

  //reset
  static Future<bool> resetpassword(
    TextEditingController email,
    TextEditingController password,
  ) async {
    Map<String, String> requestheaders = {'content-type': 'application/json'};
    var url = Uri.http(ApiURL.apiURL, ApiURL.resetpassAPI);
    var response = await client.post(url,
        headers: requestheaders,
        body: jsonEncode({"email": email.text, "password": password.text}));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //logout
  static Future<void> logout(BuildContext context) async {
    Provider.of<UserProvider>(context, listen: false).logout();
    LoginSharedPreferences().clearloginToken();
  }
}
