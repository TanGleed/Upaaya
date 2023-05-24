import 'dart:convert';
import 'dart:io';
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
  Future<http.StreamedResponse> postJob(JobPost jobPost) async {
    var url = Uri.http(ApiURL.apiURL, ApiURL.jobAPI);
    var request = http.MultipartRequest('POST', url);

    // Add JSON body to the request
    request.fields['title'] = jobPost.title;
    request.fields['location'] = jobPost.location;
    request.fields['description'] = jobPost.description;
    request.fields['additionalInfo'] = jobPost.additionalInfo;
    request.fields['latitude'] = jobPost.latitude.toString();
    request.fields['longitude'] = jobPost.longitude.toString();
    request.fields['tags'] = jobPost.tags;

    // Add media files to the request as files
    for (var file in jobPost.media) {
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile(
        'media',
        stream,
        length,
        filename: file.path,
      );

      request.files.add(multipartFile);
    }

    // Send the request
    var response = await request.send();

    // Handle the response
    if (response.statusCode == 201) {
      return response;
    } else {
      return http.StreamedResponse(
          'Cannot Post Job' as Stream<List<int>>, response.statusCode);
    }
  }

  static Future<http.BaseResponse> changeImage(
    String email,
    File imagefile,
  ) async {
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
