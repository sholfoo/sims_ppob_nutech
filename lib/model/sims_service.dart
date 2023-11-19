// To parse this JSON data, do
//
//     final simsService = simsServiceFromJson(jsonString);

import 'dart:convert';

SimsService simsServiceFromJson(String str) =>
    SimsService.fromJson(json.decode(str));

String simsServiceToJson(SimsService data) => json.encode(data.toJson());

class SimsService {
  int status;
  String message;
  List<Datum> data;

  SimsService({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SimsService.fromJson(Map<String, dynamic> json) => SimsService(
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
  String serviceCode;
  String serviceName;
  String serviceIcon;
  int serviceTariff;

  Datum({
    required this.serviceCode,
    required this.serviceName,
    required this.serviceIcon,
    required this.serviceTariff,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        serviceCode: json["service_code"],
        serviceName: json["service_name"],
        serviceIcon: json["service_icon"],
        serviceTariff: json["service_tariff"],
      );

  Map<String, dynamic> toJson() => {
        "service_code": serviceCode,
        "service_name": serviceName,
        "service_icon": serviceIcon,
        "service_tariff": serviceTariff,
      };
}
