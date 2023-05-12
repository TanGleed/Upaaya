import 'dart:convert';
import 'package:client_app/constants/global_variable.dart';
import 'package:client_app/providers/UserProvider.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../sharedpreferences.dart';

class UserServices {
  static var client = http.Client();
  static Future<bool> addprofile(String name, String dob, String contact,
      String address, BuildContext context) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(ApiURL.apiURL, ApiURL.addprofileAPI);
    var id = await LoginSharedPreferences().getloginToken();
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "usertoken": id,
          "name": name,
          "contact": contact,
          "DOB": dob,
          "address": address,
        },
      ),
    );
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Provider.of<UserProvider>(context, listen: false)
          .setLoginDetails(response.body);
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> udpateprofile(String name, String dob, String contact,
      String address, BuildContext context) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(ApiURL.apiURL, ApiURL.updateUserProfileAPI);
    var id = await LoginSharedPreferences().getloginToken();
    var email = "sudeepbhattarai1792@gmail.com";
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "usertoken": id,
          "name": name,
          "contact": email,
          "DOB": dob,
          "address": address,
        },
      ),
    );
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Provider.of<UserProvider>(context, listen: false)
          .setLoginDetails(response.body);
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> getProfile(BuildContext context) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(ApiURL.apiURL, ApiURL.getUserProfileAPI);
    var email = "sudeepbhattarai1792@gmail.com";
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {"contact": email},
      ),
    );

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Provider.of<UserProvider>(context, listen: true)
          .setLoginDetails(response.body);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> initializeuser(BuildContext context, token) async {
    getProfile(context).then(
      (value) {
        if (value) {
          const SnackBar(
            content: Text('Successfully logged In'),
          );
          return true;
        } else {
          const SnackBar(
            content: Text('InitializtionFailed Try loggiing In'),
          );
          return false;
        }
      },
    );
    return false;
  }
}
