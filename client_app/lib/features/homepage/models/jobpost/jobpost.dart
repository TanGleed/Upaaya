class JobPost {
  String title;
  String description;
  String location;
  List<String> tags;
  String additionalInfo;
  JobPost({
    required this.title,
    required this.description,
    required this.location,
    required this.tags,
    required this.additionalInfo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["description"] = description;
    data['location'] = location;
    data['tags'] = tags;
    data['additionalInfo'] = additionalInfo;
    return data;
  }
}
