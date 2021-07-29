import 'package:filmax/api_service.dart';
import 'package:filmax/domain/entities/movie_video.dart';
import 'package:filmax/presentation/bloc/detailmovie/detailmovie_bloc.dart';
import 'package:filmax/presentation/bloc/movievideo/movievideo_bloc.dart'
    as video;
import 'package:filmax/presentation/bloc/review/review_bloc.dart' as review;
import 'package:filmax/presentation/pages/movie_detail/detail_movie_widget.dart';
import 'package:filmax/presentation/pages/movie_detail/detail_nodata_widget.dart';
import 'package:filmax/presentation/pages/movie_detail/review_list_widget.dart';
import 'package:filmax/presentation/pages/movie_detail/video_movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shine/flutter_shine.dart';

import '../../../core/common/styles.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/movie_detail';

  final String id;

  const MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.id != "") {
      BlocProvider.of<review.ReviewBloc>(context)
          .add(review.GetDataForReview(widget.id));
      BlocProvider.of<video.MovievideoBloc>(context)
          .add(video.GetDataForMovievideo(widget.id));
      BlocProvider.of<DetailmovieBloc>(context)
          .add(GetDataForDetailmovie(widget.id));
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: primaryBarColor,
      ),
      child: BlocBuilder<DetailmovieBloc, DetailmovieState>(
        builder: (context, state) {
          if (state is Empty) {
            return DetailNoDataWidget(message: "empty", jenis: "");
          } else if (state is Loading) {
            return DetailNoDataWidget(message: "loading", jenis: "loading");
          } else if (state is Loaded) {
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 250,
                            child: Hero(
                              tag: state.data.id,
                              child: state.data.posterPath != ""
                                  ? Image.network(
                                      ApiService.baseUrlImage +
                                          state.data.posterPath,
                                      height: 250,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      height: 250,
                                      color: Colors.grey,
                                    ),
                            ),
                          ),
                          Positioned(
                            top: 100,
                            left: 10,
                            right: 10,
                            child: FlutterShine(builder: (BuildContext context,
                                ShineShadow? shineShadow) {
                              return Text(
                                state.data.title,
                                textAlign: TextAlign.center,
                                style: shineShadow != null
                                    ? TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        shadows: shineShadow.shadows,
                                      )
                                    : TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),
                              );
                            }),
                          ),
                          VideoMovieWidget(),
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 460, left: 15, right: 15, bottom: 15),
                              child: Column(
                                children: [
                                  DetailMovieWidget(detailMovie: state.data),
                                  ReviewListWidget(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is Error) {
            return DetailNoDataWidget(message: state.message, jenis: "");
          } else {
            return DetailNoDataWidget(message: "", jenis: "");
          }
        },
      ),
    );
  }

  String videoKey(List<MovieVideo> data) {
    String hasil = "";
    for (int i = 0; i < data.length; i++) {
      if (data[i].site != "" && data[i].site != "null") {
        if (data[i].key != "" && data[i].key != "null") {
          if (hasil == "") {
            print("bayu 1 " + data[i].site.toLowerCase());
            hasil = data[i].key;
          }
        }
      }
    }
    print("bayu " + hasil);
    return hasil;
  }
}
