// To parse this JSON data, do
//
//     final reviewRemote = reviewRemoteFromJson(jsonString?);

import 'dart:convert';

ReviewRemote reviewRemoteFromJson(String? str) =>
    ReviewRemote.fromJson(json.decode(str!));

String? reviewRemoteToJson(ReviewRemote data) => json.encode(data.toJson());

class ReviewRemote {
  ReviewRemote({
    this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? id;
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  factory ReviewRemote.fromJson(Map<String?, dynamic> json) => ReviewRemote(
        id: json["id"],
        page: json["page"],
        results: json["results"] != null
            ? List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
            : null,
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "page": page,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  Result({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  String? author;
  AuthorDetails? authorDetails;
  String? content;
  DateTime? createdAt;
  String? id;
  DateTime? updatedAt;
  String? url;

  factory Result.fromJson(Map<String?, dynamic> json) => Result(
        author: json["author"],
        authorDetails: json["author_details"] != null
            ? AuthorDetails.fromJson(json["author_details"])
            : null,
        content: json["content"],
        createdAt: json["created_at"] != null
            ? DateTime?.parse(json["created_at"])
            : null,
        id: json["id"],
        updatedAt: json["updated_at"] != null
            ? DateTime?.parse(json["updated_at"])
            : null,
        url: json["url"],
      );

  Map<String?, dynamic> toJson() => {
        "author": author,
        "author_details": authorDetails!.toJson(),
        "content": content,
        "created_at": createdAt!.toIso8601String(),
        "id": id,
        "updated_at": updatedAt!.toIso8601String(),
        "url": url,
      };
}

class AuthorDetails {
  AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  String? name;
  String? username;
  String? avatarPath;
  double? rating;

  factory AuthorDetails.fromJson(Map<String?, dynamic> json) => AuthorDetails(
        name: json["name"],
        username: json["username"],
        avatarPath: json["avatar_path"] == null ? null : json["avatar_path"],
        rating: json["rating"] == null ? null : json["rating"],
      );

  Map<String?, dynamic> toJson() => {
        "name": name,
        "username": username,
        "avatar_path": avatarPath == null ? null : avatarPath,
        "rating": rating == null ? null : rating,
      };
}
