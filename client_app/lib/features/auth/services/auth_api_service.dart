import 'dart:convert';

import 'package:client_app/constants/globalVariable.dart';
import 'package:http/http.dart' as http;

class AuthAPIService {
  static var client = http.Client();
  static Future<bool> register(
    String fullname,
    String email,
    String password,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(ApiURL.apiURL, ApiURL.signupAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "email": email,
          "password": password,
        },
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
