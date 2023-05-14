import 'dart:developer';

import 'package:client_app/features/homepage/services/homepageServices.dart';

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
      final http.Response response = (await HomePageServices().postJob(job));
      if (response.statusCode == 201) {
        isJobPosted = true;
        notifyListeners();
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
