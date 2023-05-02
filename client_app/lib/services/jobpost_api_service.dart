import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:client_app/features/homepage/models/jobpost/jobpost.dart';
import 'package:client_app/constants/global_variable.dart';

Future<http.Response> postJob(JobPost job) async {
  try {
    final response = await http.post(
      Uri.parse("${ApiURL.apiURL}${ApiURL.jobAPI}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(job.toJson()),
    );
    return response;
  } catch (err) {
    log(err.toString());
    return http.Response('Error posting Job', 500);
  }
}
