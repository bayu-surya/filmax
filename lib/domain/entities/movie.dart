import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
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

  @override
  List<Object> get props => throw [
        adult,
        backdropPath,
        genreIds,
        id,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
      ];

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
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
