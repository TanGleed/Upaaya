import 'dart:convert';

import 'package:client_app/constants/global_variable.dart';
import 'package:http/http.dart' as http;

class UserServices {
  static var client = http.Client();
  static Future<bool> addprofile(
      String name, String dob, String contact, String address) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(ApiURL.apiURL, ApiURL.addprofileAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "name": name,
          "contact": contact,
          "DOB": dob,
          "address": address,
        },
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> getProfile(String contact) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(ApiURL.apiURL, ApiURL.getprofileAPI);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
