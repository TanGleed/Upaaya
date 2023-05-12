import 'dart:convert';

class User {
  final String name;
  final String email;
  final String userId;
  final String usertoken;
  final String contactno;
  final String dob;
  final String address;
  User({
    required this.name,
    required this.email,
    required this.userId,
    required this.usertoken,
    required this.address,
    required this.contactno,
    required this.dob,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["data"]['name'] ?? " ",
      email: json["data"]['email'] ?? " ",
      userId: json["data"]["_id"] ?? " ",
      usertoken: json["data"]["usertoken"] ?? " ",
      address: json["data"]["address"] ?? " ",
      contactno: json["data"]["contact"] ?? "",
      dob: json["data"]["DOB"] ?? " ",
    );
  }

  factory User.userResponseJson(String str) => User.fromJson(json.decode(str));
}
