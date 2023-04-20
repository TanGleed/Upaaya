import 'dart:convert';

LoginResponseModel loginResponseJson(String str) => LoginResponseModel.fromJson(
      json.decode(str),
    );

class LoginResponseModel {
  late final String message;
  late final Data data;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['message'] = message;
    _data['data'] = data.toJson();

    return _data;
  }
}

class Data {
  late final String name;
  late final String email;
  late final String userId;
  late final String usertoken;

  Data({
    required this.name,
    required this.email,
    required this.userId,
    required this.usertoken,
  });

  Data.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    userId = json["_id"];
    usertoken = json["usertoken"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['name'] = name;
    _data['email'] = email;
    _data['_Id'] = userId;
    _data['usertoken'] = name;

    return _data;
  }
}
