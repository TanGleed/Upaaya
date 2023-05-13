import 'dart:convert';

import 'dart:io';
import 'package:client_app/constants/global_variable.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

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

      return true;
    } else {
      return false;
    }
  }

  static Future<http.Response> udpateprofile(
      String name, String dob, String contact, String address) async {
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
      // Provider.of<UserProvider>(context, listen: false)
      //     .setUserDetails(response.body);
      return response;
    } else {
      return http.Response('Error Updating', 500);
    }
  }

  static Future<http.Response> getProfile(String email) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(ApiURL.apiURL, ApiURL.getUserProfileAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {"contact": email},
      ),
    );

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously

      return response;
    } else {
      return http.Response('Cannot Find User', 500);
    }
  }

  static Future<http.BaseResponse> changeImage(
    String email,
    File imagefile,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(ApiURL.apiURL, ApiURL.updateUserImageAPI);
    var request = http.MultipartRequest('POST', url);
    request.fields['contact'] = email;
    request.files.add(http.MultipartFile.fromBytes(
        'profileImage', File(imagefile.path).readAsBytesSync(),
        filename: imagefile.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously

      return response;
    } else {
      return http.Response('Cannot Find User', 500);
    }
  }
}
