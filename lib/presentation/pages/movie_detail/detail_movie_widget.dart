import 'package:filmax/core/common/styles.dart';
import 'package:filmax/domain/entities/detail_movie.dart';
import 'package:filmax/presentation/bloc/deleterating/delete_rating_bloc.dart'
    as delete;
import 'package:filmax/presentation/bloc/ratemovie/rate_movie_bloc.dart'
    as rate;
import 'package:filmax/presentation/bloc/user/user_bloc.dart' as user;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailMovieWidget extends StatelessWidget {
  final DetailMovie detailMovie;

  const DetailMovieWidget({
    Key? key,
    required this.detailMovie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.7,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text('Rating : ' + detailMovie.voteAverage.toString()),
            SizedBox(height: 10),
            Text('Bahasa : ' +
                (detailMovie.originalLanguage == "en"
                    ? "english"
                    : detailMovie.originalLanguage)),
            SizedBox(height: 10),
            Text('Budget : USD ' + detailMovie.budget.toString()),
            SizedBox(height: 10),
            Text('Tanggal rilis : ' +
                (detailMovie.releaseDate.toString().length > 10
                    ? detailMovie.releaseDate.toString().substring(0, 10)
                    : detailMovie.releaseDate.toString())),
            SizedBox(height: 10),
            Text('Genre : ' + _genreArrayToString(detailMovie.genres)),
            SizedBox(height: 10),
            Text('Detail : ' + detailMovie.overview),
            SizedBox(height: 10),
            BlocBuilder<user.UserBloc, user.UserState>(
              builder: (context, stateUser) {
                return BlocBuilder<rate.RateMovieBloc, rate.RateMovieState>(
                  builder: (context, stateRate) {
                    if (stateRate is rate.Loaded) {
                      _showToast(stateRate.data.statusMessage ?? "berhasil",
                          true, true);
                      BlocProvider.of<rate.RateMovieBloc>(context)
                          .add(rate.GetDataForRateMovieReset());
                    } else if (stateRate is rate.Error) {
                      _showToast(stateRate.message, false, true);
                      BlocProvider.of<rate.RateMovieBloc>(context)
                          .add(rate.GetDataForRateMovieReset());
                    }
                    return BlocBuilder<delete.DeleteRatingBloc,
                        delete.DeleteRatingState>(
                      builder: (context, stateDelete) {
                        if (stateDelete is delete.Loaded) {
                          _showToast(
                              stateDelete.data.statusMessage ?? "berhasil",
                              true,
                              false);
                          BlocProvider.of<delete.DeleteRatingBloc>(context)
                              .add(delete.GetDataForDeleteReset());
                        } else if (stateDelete is delete.Error) {
                          _showToast(stateDelete.message, false, false);
                          BlocProvider.of<delete.DeleteRatingBloc>(context)
                              .add(delete.GetDataForDeleteReset());
                        }
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 165,
                              child: RatingBar.builder(
                                wrapAlignment: WrapAlignment.start,
                                itemSize: 25,
                                initialRating: 0,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 10,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: primaryColor,
                                ),
                                onRatingUpdate: (rating) {
                                  if (stateUser is user.Loaded) {
                                    BlocProvider.of<rate.RateMovieBloc>(context)
                                        .add(rate.GetDataForRateMovie(
                                      idMovie: detailMovie.id.toString(),
                                      guestId: stateUser.data.sessionId!,
                                      sessionId: stateUser.data.sessionId!,
                                    ));
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                if (stateUser is user.Loaded) {
                                  BlocProvider.of<delete.DeleteRatingBloc>(
                                          context)
                                      .add(delete.GetDataForDelete(
                                    idMovie: detailMovie.id.toString(),
                                    guestId: stateUser.data.sessionId!,
                                    sessionId: stateUser.data.sessionId!,
                                  ));
                                }
                              },
                              child: Icon(
                                Icons.delete,
                                size: 25,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _genreArrayToString(List<Genre> data) {
    String hasil = "";
    for (int i = 0; i < data.length; i++) {
      if (i == 0) {
        hasil = hasil + data[i].name;
      } else if (i == data.length - 1) {
        hasil = hasil + data[i].name;
      } else {
        hasil = hasil + data[i].name + ", ";
      }
    }
    return hasil;
  }

  _showToast(String message, bool isLoad, bool isRate) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: isLoad == true
            ? (isRate == true ? Colors.green : Colors.blue)
            : Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
