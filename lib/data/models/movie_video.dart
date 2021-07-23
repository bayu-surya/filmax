// To parse this JSON data, do
//
//     final movieVideo = movieVideoFromJson(jsonString);

import 'dart:convert';

MovieVideo movieVideoFromJson(String str) =>
    MovieVideo.fromJson(json.decode(str));

String movieVideoToJson(MovieVideo data) => json.encode(data.toJson());

class MovieVideo {
  MovieVideo({
    required this.id,
    required this.results,
  });

  int id;
  List<Result> results;

  factory MovieVideo.fromJson(Map<String, dynamic> json) => MovieVideo(
        id: json["id"] != null ? json["id"] : "",
        results: json["results"] != null
            ? List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.id,
    required this.iso6391,
    required this.iso31661,
    required this.key,
    required this.name,
    required this.site,
    required this.size,
    required this.type,
  });

  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"] != null ? json["id"] : "",
        iso6391: json["iso_639_1"] != null ? json["iso_639_1"] : "",
        iso31661: json["iso_3166_1"] != null ? json["iso_3166_1"] : "",
        key: json["key"] != null ? json["key"] : "",
        name: json["name"] != null ? json["name"] : "",
        site: json["site"] != null ? json["site"] : "",
        size: json["size"] != null ? json["size"] : "",
        type: json["type"] != null ? json["type"] : "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "key": key,
        "name": name,
        "site": site,
        "size": size,
        "type": type,
      };
}