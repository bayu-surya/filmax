// To parse this JSON data, do
//
//     final guestSessionRemote = guestSessionRemoteFromJson(jsonString);

import 'dart:convert';

GuestSessionRemote guestSessionRemoteFromJson(String str) =>
    GuestSessionRemote.fromJson(json.decode(str));

String guestSessionRemoteToJson(GuestSessionRemote data) =>
    json.encode(data.toJson());

class GuestSessionRemote {
  GuestSessionRemote({
    this.success,
    this.guestSessionId,
    this.expiresAt,
  });

  bool? success;
  String? guestSessionId;
  String? expiresAt;

  factory GuestSessionRemote.fromJson(Map<String, dynamic> json) =>
      GuestSessionRemote(
        success: json["success"],
        guestSessionId: json["guest_session_id"],
        expiresAt: json["expires_at"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "guest_session_id": guestSessionId,
        "expires_at": expiresAt,
      };
}
