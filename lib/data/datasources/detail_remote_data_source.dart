import 'dart:convert';

import 'package:filmax/api_service.dart';
import 'package:filmax/core/error/exception.dart';
import 'package:filmax/data/models/delete_rating_response.dart';
import 'package:filmax/data/models/detail_movie.dart';
import 'package:filmax/data/models/movie_video.dart';
import 'package:filmax/data/models/rate_response.dart';
import 'package:filmax/data/models/review_remote.dart';
import 'package:http/http.dart' as http;

abstract class DetailRemoteDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<DetailMovie> getDetailMovie(String idMovie);
  Future<MovieVideo> getListMovieVideo(String idMovie);
  Future<ReviewRemote> getReview(String idMovie);
  Future<RateResponse> postRateMovie(
      String idMovie, String guestId, String sessionId);
  Future<DeleteRatingResponse> deleteRating(
      String idMovie, String guestId, String sessionId);
}

class DetailRemoteDataSourceImpl implements DetailRemoteDataSource {
  final http.Client client;

  DetailRemoteDataSourceImpl({required this.client});

  @override
  Future<DetailMovie> getDetailMovie(String idMovie) async {
    var url = Uri.parse(ApiService.baseUrl + "/movie/$idMovie?");
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
    var url = Uri.parse(ApiService.baseUrl + "/movie/$idMovie/videos?");
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

  @override
  Future<ReviewRemote> getReview(String idMovie) async {
    var url = Uri.parse(ApiService.baseUrl + "/movie/$idMovie/reviews?");
    Map<String, String> qParams = {
      'api_key': ApiService.apiKey,
      'language': 'en-US',
      'page': '1',
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await client.get(finalUri);
    if (response.statusCode == 200) {
      return ReviewRemote.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RateResponse> postRateMovie(
      String idMovie, String guestId, String sessionId) async {
    var url = Uri.parse(ApiService.baseUrl + "/movie/$idMovie/rating?");
    Map<String, String> qParams = {
      'api_key': ApiService.apiKey,
      'guest_session_id': guestId,
      'session_id': sessionId,
    };
    Map<String, String> header = {
      'Content-Type': ApiService.contentType,
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await client.post(finalUri,
        headers: header,
        body: jsonEncode({
          "value": "8",
        }));
    if (response.statusCode == 201 || response.statusCode == 200) {
      return RateResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DeleteRatingResponse> deleteRating(
      String idMovie, String guestId, String sessionId) async {
    var url = Uri.parse(ApiService.baseUrl + "/movie/$idMovie/rating?");
    Map<String, String> qParams = {
      'api_key': ApiService.apiKey,
      'guest_session_id': guestId,
      'session_id': sessionId,
    };
    Map<String, String> header = {
      "Content-Type": ApiService.contentType,
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await client.delete(finalUri, headers: header);
    if (response.statusCode == 200) {
      return DeleteRatingResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
