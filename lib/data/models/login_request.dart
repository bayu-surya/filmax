import 'dart:convert';

LoginRequest loginFromJson(String str) =>
    LoginRequest.fromJson(json.decode(str));

String loginToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  LoginRequest({
    required this.username,
    required this.password,
    required this.requestToken,
  });

  String username;
  String password;
  String requestToken;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        username: json["username"],
        password: json["password"],
        requestToken: json["request_token"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "request_token": requestToken,
      };
}
