import 'dart:convert';

import 'package:filmax/api_service.dart';
import 'package:filmax/core/error/exception.dart';
import 'package:filmax/data/models/create_session_remote.dart';
import 'package:filmax/data/models/guest_session_remote.dart';
import 'package:filmax/data/models/login_request.dart';
import 'package:filmax/data/models/request_token_remote.dart';
import 'package:filmax/data/models/session_login_remote.dart';
import 'package:http/http.dart' as http;

abstract class LoginRemoteDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<GuestSessionRemote> getGuestSession();
  Future<RequestTokenRemote> getRequestToken();
  Future<SessionLoginRemote> createSessionLogin(LoginRequest login);
  Future<CreateSessionRemote> createSession(String token);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<CreateSessionRemote> createSession(String token) async {
    var url = Uri.parse(ApiService.baseUrl + "/authentication/session/new?");
    Map<String, String> qParams = {
      'api_key': ApiService.apiKey,
    };
    Map body = {
      'request_token': token,
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await client.post(finalUri, body: body);
    if (response.statusCode == 200) {
      return CreateSessionRemote.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SessionLoginRemote> createSessionLogin(LoginRequest login) async {
    var url = Uri.parse(
        ApiService.baseUrl + "/authentication/token/validate_with_login?");
    Map<String, String> qParams = {
      'api_key': ApiService.apiKey,
    };
    Map body = {
      "username": login.username,
      "password": login.password,
      "request_token": login.requestToken
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await client.post(finalUri, body: body);
    if (response.statusCode == 200) {
      return SessionLoginRemote.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<GuestSessionRemote> getGuestSession() async {
    var url =
        Uri.parse(ApiService.baseUrl + "/authentication/guest_session/new?");
    Map<String, String> qParams = {
      'api_key': ApiService.apiKey,
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await client.get(finalUri);
    if (response.statusCode == 200) {
      return GuestSessionRemote.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RequestTokenRemote> getRequestToken() async {
    var url = Uri.parse(ApiService.baseUrl + "/authentication/token/new?");
    Map<String, String> qParams = {
      'api_key': ApiService.apiKey,
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await client.get(finalUri);
    if (response.statusCode == 200) {
      return RequestTokenRemote.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
