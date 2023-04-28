import 'dart:convert';

class User {
  final String name;
  final String email;
  final String userId;
  final String usertoken;

  User({
    required this.name,
    required this.email,
    required this.userId,
    required this.usertoken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["data"]['name'] ?? " ",
      email: json["data"]['email'] ?? " ",
      userId: json["data"]["_id"] ?? " ",
      usertoken: json["data"]["usertoken"] ?? " ",
    );
  }

  factory User.userResponseJson(String str) => User.fromJson(json.decode(str));
}
