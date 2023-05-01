import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../constants/globalVariable.dart';

part 'job.freezed.dart';
part 'job.g.dart';

List<Job> jobFromJson(dynamic str) {
  return List<Job>.from(
    (str).map(
      (x) => Job.fromJson(x),
    ),
  );
}

@freezed
abstract class Job with _$Job {
  const factory Job({
    required String id,
    required String title,
    required String location,
    required String description,
    required List<String> tags,
    required String additionalInfo,
  }) = _Job;

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
}
