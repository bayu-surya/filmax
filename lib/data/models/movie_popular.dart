import 'dart:convert';

MoviePopular moviePopularFromJson(String str) =>
    MoviePopular.fromJson(json.decode(str));

String moviePopularToJson(MoviePopular data) => json.encode(data.toJson());

class MoviePopular {
  MoviePopular({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  factory MoviePopular.fromJson(Map<String, dynamic> json) => MoviePopular(
        page: json["page"] != null ? json["page"] : "",
        results: json["results"] != null
            ? List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
            : [],
        totalPages: json["total_pages"] != null ? json["total_pages"] : "",
        totalResults:
            json["total_results"] != null ? json["total_results"] : "",
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  Result({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"] != null ? json["adult"] : "",
        backdropPath:
            json["backdrop_path"] != null ? json["backdrop_path"] : "",
        genreIds: json["genre_ids"] != null
            ? List<int>.from(json["genre_ids"].map((x) => x))
            : [],
        id: json["id"] != null ? json["id"] : "",
        originalLanguage:
            json["original_language"] != null ? json["original_language"] : "",
        originalTitle:
            json["original_title"] != null ? json["original_title"] : "",
        overview: json["overview"] != null ? json["overview"] : "",
        popularity:
            json["popularity"] != null ? json["popularity"].toDouble() : 0,
        posterPath: json["poster_path"] != null ? json["poster_path"] : "",
        releaseDate: json["release_date"] != null
            ? DateTime.parse(json["release_date"])
            : DateTime.parse("2000-01-01"),
        title: json["title"] != null ? json["title"] : "",
        video: json["video"] != null ? json["video"] : "",
        voteAverage:
            json["vote_average"] != null ? json["vote_average"].toDouble() : 0,
        voteCount: json["vote_count"] != null ? json["vote_count"] : "",
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
