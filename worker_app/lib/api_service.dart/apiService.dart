import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worker_app/constants/globalVariable.dart';
import 'package:worker_app/features/auth/services/authmodel.dart';

import '../models/job.dart';

final apiService = Provider((ref) => APIService());

//job api
class APIService {
  static var client = http.Client();

  //get jobd
  Future<List<Job>?> getJobs(page, pageSize) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString()
    };
    var url = Uri.http(ApiURL.apiURL, ApiURL.getJobsAPI, queryString);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return jobFromJson(data["data"]);
    } else {
      return null;
    }
  }

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
      TextEditingController email, TextEditingController password) async {
    Map<String, String> requestheaders = {'content-type': 'application/json'};
    var url = Uri.http(ApiURL.apiURL, ApiURL.loginAPI);
    var response = await client.post(url,
        headers: requestheaders,
        body: jsonEncode({
          "email": email.text,
          "password": password.text,
        }));
    if (response.statusCode == 200) {
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
}
