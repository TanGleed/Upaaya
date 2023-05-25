import 'dart:io';

class JobPost {
  String title;
  String description;
  String location;
  String tags;
  List<File> media;
  String additionalInfo;
  double latitude;
  double longitude;
  JobPost({
    required this.title,
    required this.description,
    required this.location,
    required this.tags,
    required this.additionalInfo,
    required this.media,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["description"] = description;
    data['location'] = location;
    data['tags'] = tags;
    data['additionalInfo'] = additionalInfo;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
