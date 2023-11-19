// To parse this JSON data, do
//
//     final simsBanners = simsBannersFromJson(jsonString);

import 'dart:convert';

SimsBanners simsBannersFromJson(String str) =>
    SimsBanners.fromJson(json.decode(str));

String simsBannersToJson(SimsBanners data) => json.encode(data.toJson());

class SimsBanners {
  int status;
  String message;
  List<Datum> data;

  SimsBanners({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SimsBanners.fromJson(Map<String, dynamic> json) => SimsBanners(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String bannerName;
  String bannerImage;
  String description;

  Datum({
    required this.bannerName,
    required this.bannerImage,
    required this.description,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bannerName: json["banner_name"],
        bannerImage: json["banner_image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "banner_name": bannerName,
        "banner_image": bannerImage,
        "description": description,
      };
}
