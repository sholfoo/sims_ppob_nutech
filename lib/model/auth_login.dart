// To parse this JSON data, do
//
//     final loginAuth = loginAuthFromJson(jsonString);

import 'dart:convert';

LoginAuth loginAuthFromJson(String str) => LoginAuth.fromJson(json.decode(str));

String loginAuthToJson(LoginAuth data) => json.encode(data.toJson());

class LoginAuth {
  int? status;
  String? message;
  Data? data;

  LoginAuth({
    this.status,
    this.message,
    this.data,
  });

  factory LoginAuth.fromJson(Map<String, dynamic> json) => LoginAuth(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? token;

  Data({
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
