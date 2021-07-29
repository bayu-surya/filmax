import 'dart:convert';

import 'package:filmax/api_service.dart';
import 'package:filmax/core/error/exception.dart';
import 'package:filmax/data/models/movie_now.dart';
import 'package:filmax/data/models/movie_popular.dart';
import 'package:filmax/data/models/movie_top.dart';
import 'package:filmax/data/models/movie_upcoming.dart';
import 'package:http/http.dart' as http;

abstract class HomeRemoteDataSource {
  // /// Calls the http://numbersapi.com/{number} endpoint.
  // ///
  // /// Throws a [ServerException] for all error codes.
  // Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Throws a [ServerException] for all error codes.
  Future<MoviePopular> getListMovePopular();
  Future<MovieTop> getListMoveTop();
  Future<MovieUpcoming> getListMovieUpcoming();
  Future<MovieNow> getListMovieNow();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final http.Client client;

  HomeRemoteDataSourceImpl({required this.client});

  // @override
  // Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
  //     _getTriviaFromUrl('http://numbersapi.com/$number');

  // @override
  // Future<NumberTriviaModel> getRandomNumberTrivia() =>
  //     _getTriviaFromUrl('http://numbersapi.com/random');
  //
  // Future<NumberTriviaModel> _getTriviaFromUrl(String urlStr) async {
  //   var url = Uri.parse(urlStr);
  //   final response = await client.get(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return NumberTriviaModel.fromJson(json.decode(response.body));
  //   } else {
  //     throw ServerException();
  //   }
  // }

  @override
  Future<MoviePopular> getListMovePopular() async {
    var url = Uri.parse(ApiService.baseUrl + "/movie/popular?");
    Map<String, String> qParams = {
      'api_key': ApiService.apiKey,
      'language': 'en-US',
      'page': '1',
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await client.get(finalUri);
    if (response.statusCode == 200) {
      return MoviePopular.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieTop> getListMoveTop() async {
    var url = Uri.parse(ApiService.baseUrl + "/movie/top_rated?");
    Map<String, String> qParams = {
      'api_key': ApiService.apiKey,
      'language': 'en-US',
      'page': '1',
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await client.get(finalUri);
    if (response.statusCode == 200) {
      return MovieTop.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieNow> getListMovieNow() async {
    var url = Uri.parse(ApiService.baseUrl + "/movie/now_playing?");
    Map<String, String> qParams = {
      'api_key': ApiService.apiKey,
      'language': 'en-US',
      'page': '1',
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await client.get(finalUri);
    if (response.statusCode == 200) {
      return MovieNow.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieUpcoming> getListMovieUpcoming() async {
    var url = Uri.parse(ApiService.baseUrl + "/movie/upcoming?");
    Map<String, String> qParams = {
      'api_key': ApiService.apiKey,
      'language': 'en-US',
      'page': '1',
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await client.get(finalUri);
    if (response.statusCode == 200) {
      return MovieUpcoming.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
