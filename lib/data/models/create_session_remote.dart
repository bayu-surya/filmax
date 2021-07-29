// To parse this JSON data, do
//
//     final createSessionRemote = createSessionRemoteFromJson(jsonString);

import 'dart:convert';

CreateSessionRemote createSessionRemoteFromJson(String str) =>
    CreateSessionRemote.fromJson(json.decode(str));

String createSessionRemoteToJson(CreateSessionRemote data) =>
    json.encode(data.toJson());

class CreateSessionRemote {
  CreateSessionRemote({
    this.success,
    this.sessionId,
  });

  bool? success;
  String? sessionId;

  factory CreateSessionRemote.fromJson(Map<String, dynamic> json) =>
      CreateSessionRemote(
        success: json["success"],
        sessionId: json["session_id"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "session_id": sessionId,
      };
}
