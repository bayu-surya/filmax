import 'package:filmax/consumerprovider/data/model/movie_now.dart' as now;
import 'package:filmax/consumerprovider/data/model/movie_popular.dart';
import 'package:filmax/consumerprovider/data/model/movie_top.dart' as top;
import 'package:filmax/consumerprovider/data/model/movie_upcoming.dart' as upcoming;

class DataMapper {

  Result movieNowToPopuler(now.Result data) {
    return Result(
      adult: data.adult,
      backdropPath: data.backdropPath,
      genreIds: data.genreIds,
      id: data.id,
      originalLanguage: data.originalLanguage,
      originalTitle: data.originalTitle,
      overview: data.overview,
      popularity: data.popularity,
      posterPath: data.posterPath,
      releaseDate: data.releaseDate,
      title: data.title,
      video: data.video,
      voteAverage: data.voteAverage,
      voteCount: data.voteCount,
    );
  }

  Result movieTopToPopuler(top.Result data) {
    return Result(
      adult: data.adult,
      backdropPath: data.backdropPath,
      genreIds: data.genreIds,
      id: data.id,
      originalLanguage: data.originalLanguage,
      originalTitle: data.originalTitle,
      overview: data.overview,
      popularity: data.popularity,
      posterPath: data.posterPath,
      releaseDate: data.releaseDate,
      title: data.title,
      video: data.video,
      voteAverage: data.voteAverage,
      voteCount: data.voteCount,
    );
  }

  Result movieUpcomingToPopuler(upcoming.Result data) {
    return Result(
      adult: data.adult,
      backdropPath: data.backdropPath,
      genreIds: data.genreIds,
      id: data.id,
      originalLanguage: data.originalLanguage.toString(),
      originalTitle: data.originalTitle,
      overview: data.overview,
      popularity: data.popularity,
      posterPath: data.posterPath,
      releaseDate: data.releaseDate,
      title: data.title,
      video: data.video,
      voteAverage: data.voteAverage,
      voteCount: data.voteCount,
    );
  }
}