import 'dart:developer';
import 'dart:io';

import 'package:client_app/features/homepage/services/homepageServices.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:client_app/features/homepage/models/jobpost/jobpost.dart';

class JobPostNotifier extends ChangeNotifier {
  bool isLoading = false;
  bool isJobPosted = false;
  JobPost _jobPost = JobPost(
    latitude: 0.0,
    title: '',
    description: '',
    location: '',
    tags: '',
    additionalInfo: '',
    media: [],
    longitude: 0.0,
  );
  JobPost get job => _jobPost;

  Future<void> post(JobPost job, List<File> images) async {
    isLoading = true;
    notifyListeners();

    try {
      final http.BaseResponse response =
          (await HomePageServices().postJob(job));
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
