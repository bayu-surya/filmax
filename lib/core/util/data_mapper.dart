import 'package:filmax/consumerprovider/data/model/movie_popular.dart'
    as consumer;
import 'package:filmax/data/models/movie_now.dart' as now;
import 'package:filmax/data/models/movie_popular.dart';
import 'package:filmax/data/models/movie_top.dart' as top;
import 'package:filmax/data/models/movie_upcoming.dart' as upcoming;
import 'package:filmax/domain/entities/movie.dart';

class DataMapper {
  // MoviePopular modelToEntitie(Movie data) {
  //   return NumberTriviaModel(
  //     number: data.number,
  //     text: data.text,
  //   );
  // }

  consumer.Result entitieToModel(Movie data) {
    return consumer.Result(
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

  List<Movie> mapMoviePopularRemoteToEntities(List<Result> data) {
    List<Movie> movieList = [];
    if (data.isNotEmpty) {
      data.forEach((element) {
        Movie movie = Movie(
          adult: element.adult,
          backdropPath: element.backdropPath,
          genreIds: element.genreIds,
          id: element.id,
          originalLanguage: element.originalLanguage,
          originalTitle: element.originalTitle,
          overview: element.overview,
          popularity: element.popularity,
          posterPath: element.posterPath,
          releaseDate: element.releaseDate,
          title: element.title,
          video: element.video,
          voteAverage: element.voteAverage,
          voteCount: element.voteCount,
        );
        movieList.add(movie);
      });
    }
    return movieList;
  }

  List<Movie> mapMovieTopRemoteToEntities(List<top.Result> data) {
    List<Movie> movieList = [];
    if (data.isNotEmpty) {
      data.forEach((element) {
        Movie movie = Movie(
          adult: element.adult,
          backdropPath: element.backdropPath,
          genreIds: element.genreIds,
          id: element.id,
          originalLanguage: element.originalLanguage,
          originalTitle: element.originalTitle,
          overview: element.overview,
          popularity: element.popularity,
          posterPath: element.posterPath,
          releaseDate: element.releaseDate,
          title: element.title,
          video: element.video,
          voteAverage: element.voteAverage,
          voteCount: element.voteCount,
        );
        movieList.add(movie);
      });
    }
    return movieList;
  }

  List<Movie> mapMovieNowRemoteToEntities(List<now.Result> data) {
    List<Movie> movieList = [];
    if (data.isNotEmpty) {
      data.forEach((element) {
        Movie movie = Movie(
          adult: element.adult,
          backdropPath: element.backdropPath,
          genreIds: element.genreIds,
          id: element.id,
          originalLanguage: element.originalLanguage,
          originalTitle: element.originalTitle,
          overview: element.overview,
          popularity: element.popularity,
          posterPath: element.posterPath,
          releaseDate: element.releaseDate,
          title: element.title,
          video: element.video,
          voteAverage: element.voteAverage,
          voteCount: element.voteCount,
        );
        movieList.add(movie);
      });
    }
    return movieList;
  }

  List<Movie> mapMovieUpcomingRemoteToEntities(List<upcoming.Result> data) {
    List<Movie> movieList = [];
    if (data.isNotEmpty) {
      data.forEach((element) {
        Movie movie = Movie(
          adult: element.adult,
          backdropPath: element.backdropPath,
          genreIds: element.genreIds,
          id: element.id,
          originalLanguage: element.originalLanguage,
          originalTitle: element.originalTitle,
          overview: element.overview,
          popularity: element.popularity,
          posterPath: element.posterPath,
          releaseDate: element.releaseDate,
          title: element.title,
          video: element.video,
          voteAverage: element.voteAverage,
          voteCount: element.voteCount,
        );
        movieList.add(movie);
      });
    }
    return movieList;
  }
}
