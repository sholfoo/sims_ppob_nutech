// To parse this JSON data, do
//
//     final registerAuth = registerAuthFromJson(jsonString);

import 'dart:convert';

RegisterAuth registerAuthFromJson(String str) =>
    RegisterAuth.fromJson(json.decode(str));

String registerAuthToJson(RegisterAuth data) => json.encode(data.toJson());

class RegisterAuth {
  int status;
  String message;
  dynamic data;

  RegisterAuth({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RegisterAuth.fromJson(Map<String, dynamic> json) => RegisterAuth(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
