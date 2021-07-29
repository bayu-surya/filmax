// To parse this JSON data, do
//
//     final rateResponse = rateResponseFromJson(jsonString);

import 'dart:convert';

RateResponse rateResponseFromJson(String str) =>
    RateResponse.fromJson(json.decode(str));

String rateResponseToJson(RateResponse data) => json.encode(data.toJson());

class RateResponse {
  RateResponse({
    this.success,
    this.statusCode,
    this.statusMessage,
  });

  bool? success;
  int? statusCode;
  String? statusMessage;

  factory RateResponse.fromJson(Map<String, dynamic> json) => RateResponse(
        success: json["success"],
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "status_message": statusMessage,
      };
}
