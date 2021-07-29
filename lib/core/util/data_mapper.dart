import 'package:filmax/data/models/delete_rating_response.dart';
import 'package:filmax/data/models/detail_movie.dart' as detailRemote;
import 'package:filmax/data/models/movie_now.dart' as now;
import 'package:filmax/data/models/movie_popular.dart';
import 'package:filmax/data/models/movie_top.dart' as top;
import 'package:filmax/data/models/movie_upcoming.dart' as upcoming;
import 'package:filmax/data/models/movie_video.dart' as videoRemote;
import 'package:filmax/data/models/rate_response.dart';
import 'package:filmax/data/models/review_remote.dart' as reviewRemote;
import 'package:filmax/domain/entities/delete_rating.dart';
import 'package:filmax/domain/entities/detail_movie.dart';
import 'package:filmax/domain/entities/movie.dart';
import 'package:filmax/domain/entities/movie_video.dart';
import 'package:filmax/domain/entities/rate.dart';
import 'package:filmax/domain/entities/review.dart';

class DataMapper {
  // MoviePopular modelToEntitie(Movie data) {
  //   return NumberTriviaModel(
  //     number: data.number,
  //     text: data.text,
  //   );
  // }

  Result entitieToModel(Movie data) {
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

  List<MovieVideo> mapMovieVideoRemoteToEntities(videoRemote.MovieVideo data) {
    List<MovieVideo> movieList = [];
    int idMovie = data.id;
    if (data.results.isNotEmpty) {
      data.results.forEach((element) {
        MovieVideo movie = MovieVideo(
          id: element.id,
          idMovie: idMovie,
          iso6391: element.iso6391,
          iso31661: element.iso31661,
          key: element.key,
          name: element.name,
          site: element.site,
          size: element.size,
          type: element.type,
        );
        movieList.add(movie);
      });
    }
    return movieList;
  }

  List<Genre> mapGenreToEntities(List<detailRemote.Genre> data) {
    List<Genre> genreList = [];
    if (data.isNotEmpty) {
      data.forEach((element) {
        Genre genre = Genre(
          id: element.id,
          name: element.name,
        );
        genreList.add(genre);
      });
    }
    return genreList;
  }

  List<ProductionCompany> mapProductionCompanyToEntities(
      List<detailRemote.ProductionCompany> data) {
    List<ProductionCompany> result = [];
    if (data.isNotEmpty) {
      data.forEach((element) {
        ProductionCompany item = ProductionCompany(
          id: element.id,
          logoPath: element.logoPath,
          name: element.name,
          originCountry: element.originCountry,
        );
        result.add(item);
      });
    }
    return result;
  }

  List<ProductionCountry> mapProductionCountryToEntities(
      List<detailRemote.ProductionCountry> data) {
    List<ProductionCountry> result = [];
    if (data.isNotEmpty) {
      data.forEach((element) {
        ProductionCountry item = ProductionCountry(
          iso31661: element.iso31661,
          name: element.name,
        );
        result.add(item);
      });
    }
    return result;
  }

  List<SpokenLanguage> mapSpokenLanguageToEntities(
      List<detailRemote.SpokenLanguage> data) {
    List<SpokenLanguage> result = [];
    if (data.isNotEmpty) {
      data.forEach((element) {
        SpokenLanguage item = SpokenLanguage(
          englishName: element.englishName,
          iso6391: element.iso6391,
          name: element.name,
        );
        result.add(item);
      });
    }
    return result;
  }

  BelongsToCollection mapBelongsToCollectionToEntities(
      detailRemote.BelongsToCollection data) {
    return BelongsToCollection(
      id: data.id,
      name: data.name,
      posterPath: data.posterPath,
      backdropPath: data.backdropPath,
    );
  }

  DetailMovie mapDetailMovieRemoteToEntities(detailRemote.DetailMovie data) {
    return DetailMovie(
      adult: data.adult,
      backdropPath: data.backdropPath,
      belongsToCollection:
          mapBelongsToCollectionToEntities(data.belongsToCollection),
      budget: data.budget,
      genres: mapGenreToEntities(data.genres),
      homepage: data.homepage,
      id: data.id,
      imdbId: data.imdbId,
      originalLanguage: data.originalLanguage,
      originalTitle: data.originalTitle,
      overview: data.overview,
      popularity: data.popularity,
      posterPath: data.posterPath,
      productionCompanies:
          mapProductionCompanyToEntities(data.productionCompanies),
      productionCountries:
          mapProductionCountryToEntities(data.productionCountries),
      releaseDate: data.releaseDate,
      revenue: data.revenue,
      runtime: data.runtime,
      spokenLanguages: mapSpokenLanguageToEntities(data.spokenLanguages),
      status: data.status,
      tagline: data.tagline,
      title: data.title,
      video: data.video,
      voteAverage: data.voteAverage,
      voteCount: data.voteCount,
    );
  }

  AuthorDetails mapAuthorDetailsToEntities(reviewRemote.AuthorDetails data) {
    return AuthorDetails(
      name: data.name,
      username: data.username,
      avatarPath: data.avatarPath,
      rating: data.rating,
    );
  }

  List<Review> mapReviewRemoteToEntities(reviewRemote.ReviewRemote data) {
    List<Review> result = [];
    int? idMovie = data.id;
    if (data.results!.isNotEmpty) {
      data.results!.forEach((element) {
        Review movie = Review(
          idMovie: idMovie.toString(),
          author: element.author,
          authorDetails: element.authorDetails != null
              ? mapAuthorDetailsToEntities(element.authorDetails!)
              : null,
          content: element.content,
          createdAt: element.createdAt,
          id: element.id,
          updatedAt: element.updatedAt,
          url: element.url,
        );
        result.add(movie);
      });
    }
    return result;
  }

  DeleteRating mapDeleteRatingResponseToEntities(DeleteRatingResponse data) {
    return DeleteRating(
      success: data.success,
      statusMessage: data.statusMessage,
    );
  }

  Rate mapRateResponseToEntities(RateResponse data) {
    return Rate(
      success: data.success,
      statusMessage: data.statusMessage,
    );
  }

  // GuestSession mapGuestSessionRemoteToEntities(GuestSessionRemote data) {
  //   return GuestSession(
  //     success: data.success,
  //     guestSessionId: data.guestSessionId,
  //     expiresAt: data.expiresAt,
  //   );
  // }
  //
  // SessionLogin mapSessionLoginRemoteToEntities(SessionLoginRemote data) {
  //   return SessionLogin(
  //     success: data.success,
  //     expiresAt: data.expiresAt,
  //     requestToken: data.requestToken,
  //   );
  // }
  //
  // CreateSession mapCreateSessionRemoteToEntities(CreateSessionRemote data) {
  //   return CreateSession(
  //     success: data.success,
  //     sessionId: data.sessionId,
  //   );
  // }
}
