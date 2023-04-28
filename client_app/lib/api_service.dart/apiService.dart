import 'dart:convert';
import 'package:client_app/features/homepage/models/category.dart';
import 'package:client_app/providers/UserProvider.dart';
import 'package:http/http.dart' as http;
import 'package:client_app/constants/globalVariable.dart';
import 'package:client_app/features/auth/services/authmodel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as pro;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/auth/services/loginresponsemodel.dart';

final apiService = pro.Provider((ref) => APIService());

class APIService {
  static var client = http.Client();

  //get categories
  Future<List<Category>?> getCategories(page, pageSize) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString()
    };
    var url = Uri.http(ApiURL.apiURL, ApiURL.categoryAPI, queryString);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return categoriesFromJson(data["data"]);
    } else {
      return null;
    }
  }
}
