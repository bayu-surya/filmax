// To parse this JSON data, do
//
//     final requestTokenRemote = requestTokenRemoteFromJson(jsonString);

import 'dart:convert';

RequestTokenRemote requestTokenRemoteFromJson(String str) =>
    RequestTokenRemote.fromJson(json.decode(str));

String requestTokenRemoteToJson(RequestTokenRemote data) =>
    json.encode(data.toJson());

class RequestTokenRemote {
  RequestTokenRemote({
    this.success,
    this.expiresAt,
    this.requestToken,
  });

  bool? success;
  String? expiresAt;
  String? requestToken;

  factory RequestTokenRemote.fromJson(Map<String, dynamic> json) =>
      RequestTokenRemote(
        success: json["success"],
        expiresAt: json["expires_at"],
        requestToken: json["request_token"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "expires_at": expiresAt,
        "request_token": requestToken,
      };
}
