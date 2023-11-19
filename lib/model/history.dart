// To parse this JSON data, do
//
//     final history = historyFromJson(jsonString);

import 'dart:convert';

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
  int status;
  String message;
  Data data;

  History({
    required this.status,
    required this.message,
    required this.data,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String offset;
  String limit;
  List<Record> records;

  Data({
    required this.offset,
    required this.limit,
    required this.records,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        offset: json["offset"],
        limit: json["limit"],
        records:
            List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
      };
}

class Record {
  String invoiceNumber;
  String transactionType;
  String description;
  int totalAmount;
  DateTime createdOn;

  Record({
    required this.invoiceNumber,
    required this.transactionType,
    required this.description,
    required this.totalAmount,
    required this.createdOn,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        invoiceNumber: json["invoice_number"],
        transactionType: json["transaction_type"],
        description: json["description"],
        totalAmount: json["total_amount"],
        createdOn: DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "invoice_number": invoiceNumber,
        "transaction_type": transactionType,
        "description": description,
        "total_amount": totalAmount,
        "created_on": createdOn.toIso8601String(),
      };
}
