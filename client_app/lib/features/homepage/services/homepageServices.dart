import 'dart:convert';
import 'dart:math';
import 'package:client_app/constants/global_variable.dart';
import 'package:client_app/features/homepage/models/category.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:client_app/features/homepage/models/jobpost/jobpost.dart';

final homepageAPI = Provider(
  (ref) => HomePageServices(),
);

class HomePageServices {
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

  // post job
  Future<http.Response> postJob(JobPost jobPost) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    http.Response? response;
    var url = Uri.http(ApiURL.apiURL, ApiURL.jobAPI);
    try {
      response = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(jobPost.toJson()),
      );
      return response;
    } catch (e) {
      log(e.toString() as num);
      return http.Response('Error Job Posting', 500);
    }
  }
}
