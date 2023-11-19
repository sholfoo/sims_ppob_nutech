// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  int status;
  String message;
  Data data;

  Transaction({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
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
  String invoiceNumber;
  String serviceCode;
  String serviceName;
  String transactionType;
  int totalAmount;
  DateTime createdOn;

  Data({
    required this.invoiceNumber,
    required this.serviceCode,
    required this.serviceName,
    required this.transactionType,
    required this.totalAmount,
    required this.createdOn,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        invoiceNumber: json["invoice_number"],
        serviceCode: json["service_code"],
        serviceName: json["service_name"],
        transactionType: json["transaction_type"],
        totalAmount: json["total_amount"],
        createdOn: DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "invoice_number": invoiceNumber,
        "service_code": serviceCode,
        "service_name": serviceName,
        "transaction_type": transactionType,
        "total_amount": totalAmount,
        "created_on": createdOn.toIso8601String(),
      };
}
