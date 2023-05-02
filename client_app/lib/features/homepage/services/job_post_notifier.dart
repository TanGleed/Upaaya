import 'dart:developer';

import 'package:client_app/services/jobpost_api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:client_app/features/homepage/models/jobpost/jobpost.dart';

class JobPostNotifier extends ChangeNotifier {
  bool isLoading = false;
  bool isJobPosted = false;

  Future<void> post(JobPost job) async {
    isLoading = true;
    notifyListeners();

    try {
      http.Response response = (await postJob(job));
      if (response.statusCode == 200) {
        isJobPosted = true;
      } else {
        throw Exception('Failed to post job');
      }
    } catch (e) {
      // Handle the error here, for example by showing a snackbar
      log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
