// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  int? status;
  String? message;
  Data? data;

  Profile({
    this.status,
    this.message,
    this.data,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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
  String? email;
  String? firstName;
  String? lastName;
  String? profileImage;

  Data({
    this.email,
    this.firstName,
    this.lastName,
    this.profileImage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "profile_image": profileImage,
      };
}
