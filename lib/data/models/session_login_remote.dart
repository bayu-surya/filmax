// To parse this JSON data, do
//
//     final sessionLoginRemote = sessionLoginRemoteFromJson(jsonString);

import 'dart:convert';

SessionLoginRemote sessionLoginRemoteFromJson(String str) =>
    SessionLoginRemote.fromJson(json.decode(str));

String sessionLoginRemoteToJson(SessionLoginRemote data) =>
    json.encode(data.toJson());

class SessionLoginRemote {
  SessionLoginRemote({
    this.success,
    this.expiresAt,
    this.requestToken,
  });

  bool? success;
  String? expiresAt;
  String? requestToken;

  factory SessionLoginRemote.fromJson(Map<String, dynamic> json) =>
      SessionLoginRemote(
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
