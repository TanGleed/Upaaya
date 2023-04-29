import 'dart:convert';
import 'package:client_app/constants/global_variable.dart';
import 'package:client_app/features/homepage/models/category.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final homepageAPI = Provider(
  (ref) => HomePageServies(),
);

class HomePageServies {
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
