// To parse this JSON data, do
//
//     final deleteRatingResponse = deleteRatingResponseFromJson(jsonString);

import 'dart:convert';

DeleteRatingResponse deleteRatingResponseFromJson(String str) =>
    DeleteRatingResponse.fromJson(json.decode(str));

String deleteRatingResponseToJson(DeleteRatingResponse data) =>
    json.encode(data.toJson());

class DeleteRatingResponse {
  DeleteRatingResponse({
    this.success,
    this.statusCode,
    this.statusMessage,
  });

  bool? success;
  int? statusCode;
  String? statusMessage;

  factory DeleteRatingResponse.fromJson(Map<String, dynamic> json) =>
      DeleteRatingResponse(
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
