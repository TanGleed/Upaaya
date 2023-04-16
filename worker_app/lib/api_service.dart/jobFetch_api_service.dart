import 'dart:convert';
import 'package:http/http.dart' as http;

class Job {
  final String id;
  final String title;
  final String location;
  final String description;
  final List<String> tags;
  final String additionalInfo;
  final String media;

  Job({
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.tags,
    required this.additionalInfo,
    required this.media,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['_id'],
      title: json['title'],
      location: json['location'],
      description: json['description'],
      tags: List<String>.from(json['tags']),
      additionalInfo: json['additionalInfo'],
      media: json['media'],
    );
  }
}

class JobService {
  static const String _baseUrl = '192.168.10.65';

  static Future<List<Job>> getAllJobs() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final jobsJson = jsonDecode(response.body) as List<dynamic>;
      final jobs = jobsJson.map((jobJson) => Job.fromJson(jobJson)).toList();
      return jobs;
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}

Future<List<Job>> fetchJobs() async {
  final jobs = await JobService.getAllJobs();
  return jobs;
}
