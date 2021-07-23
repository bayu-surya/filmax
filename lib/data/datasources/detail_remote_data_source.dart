import 'dart:convert';

import 'package:filmax/core/error/exception.dart';
import 'package:filmax/core/util/api_service.dart';
import 'package:filmax/data/models/detail_movie.dart';
import 'package:filmax/data/models/movie_video.dart';
import 'package:http/http.dart' as http;

abstract class DetailRemoteDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<DetailMovie> getDetailMovie(String idMovie);
  Future<MovieVideo> getListMovieVideo(String idMovie);
}

class DetailRemoteDataSourceImpl implements DetailRemoteDataSource {
  final http.Client client;

  DetailRemoteDataSourceImpl({required this.client});

  @override
  Future<DetailMovie> getDetailMovie(String idMovie) async {
    var url = Uri.parse(ApiService.baseUrl + "3/movie/$idMovie?");
    Map<String, String> qParams = {
      'api_key': ApiService.apiKey,
      'language': 'en-US',
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await client.get(finalUri);
    if (response.statusCode == 200) {
      return DetailMovie.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieVideo> getListMovieVideo(String idMovie) async {
    var url = Uri.parse(ApiService.baseUrl + "3/movie/$idMovie/videos?");
    Map<String, String> qParams = {
      'api_key': ApiService.apiKey,
      'language': 'en-US',
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await client.get(finalUri);
    if (response.statusCode == 200) {
      return MovieVideo.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
