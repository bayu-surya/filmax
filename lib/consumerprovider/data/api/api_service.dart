import 'dart:convert';

import 'package:filmax/consumerprovider/data/model/detail_movie.dart';
import 'package:filmax/consumerprovider/data/model/movie_now.dart';
import 'package:filmax/consumerprovider/data/model/movie_popular.dart';
import 'package:filmax/consumerprovider/data/model/movie_top.dart';
import 'package:filmax/consumerprovider/data/model/movie_upcoming.dart';
import 'package:filmax/consumerprovider/data/model/movie_video.dart';
import 'package:http/http.dart' as http;

class ApiService {

  static final String _baseUrl = 'https://api.themoviedb.org/';
  static final String _apiKey = "a7e5bd97b3737c57d65db1ef02b5eee9";
  static final String baseUrlImage = 'https://www.themoviedb.org/t/p/original';
  static final String baseUrlYoutube = 'https://www.youtube.com/watch?v=';
  static final String baseUrlVimeo = 'https://vimeo.com/';

  Future<MoviePopular> getListMoviePopuler() async {
    var url = Uri.parse(_baseUrl +"3/movie/popular?");
    Map<String, String> qParams = {
      'api_key': _apiKey,
      'language': 'en-US',
      'page': '1',
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await http.get(finalUri);
    if (response.statusCode == 200) {
      return MoviePopular.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list movie');
    }
  }

  Future<MovieNow> getListMovieNow() async {
    var url = Uri.parse(_baseUrl +"3/movie/now_playing?");
    Map<String, String> qParams = {
      'api_key': _apiKey,
      'language': 'en-US',
      'page': '1',
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await http.get(finalUri);
    if (response.statusCode == 200) {
      return MovieNow.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list movie');
    }
  }

  Future<MovieTop> getListMovieTop() async {
    var url = Uri.parse(_baseUrl +"3/movie/top_rated?");
    Map<String, String> qParams = {
      'api_key': _apiKey,
      'language': 'en-US',
      'page': '1',
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await http.get(finalUri);
    if (response.statusCode == 200) {
      return MovieTop.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list movie');
    }
  }

  Future<MovieUpcoming> getListMovieUpcoming() async {
    var url = Uri.parse(_baseUrl +"3/movie/upcoming?");
    Map<String, String> qParams = {
      'api_key': _apiKey,
      'language': 'en-US',
      'page': '1',
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await http.get(finalUri);
    if (response.statusCode == 200) {
      return MovieUpcoming.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list movie');
    }
  }

  Future<MovieVideo> getListMovieVideo(String idMovie) async {
    var url = Uri.parse(_baseUrl +"3/movie/$idMovie/videos?");
    Map<String, String> qParams = {
      'api_key': _apiKey,
      'language': 'en-US',
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await http.get(finalUri);
    if (response.statusCode == 200) {
      return MovieVideo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list movie');
    }
  }

  Future<DetailMovie> getDetailMovie(String idMovie) async {
    var url = Uri.parse(_baseUrl +"3/movie/$idMovie?");
    Map<String, String> qParams = {
      'api_key': _apiKey,
      'language': 'en-US',
    };
    final finalUri = url.replace(queryParameters: qParams);
    final response = await http.get(finalUri);
    if (response.statusCode == 200) {
      return DetailMovie.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list movie');
    }
  }
}