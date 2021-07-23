import 'package:filmax/core/util/api_service.dart';
import 'package:filmax/domain/entities/detail_movie.dart';
import 'package:filmax/domain/entities/movie_video.dart';
import 'package:filmax/presentation/bloc/detailmovie/detailmovie_bloc.dart';
import 'package:filmax/presentation/bloc/movievideo/movievideo_bloc.dart'
    as video;
import 'package:filmax/presentation/widgets/video_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shine/flutter_shine.dart';
import 'package:video_player/video_player.dart';

import '../../core/common/styles.dart';

class MovieDetailPage extends StatelessWidget {
  static const routeName = '/movie_detail';

  final String id;

  const MovieDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    if (id != "") {
      BlocProvider.of<video.MovievideoBloc>(context)
          .add(video.GetDataForMovievideo(id));
      BlocProvider.of<DetailmovieBloc>(context).add(GetDataForDetailmovie(id));
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: primaryBarColor,
      ),
      child: BlocBuilder<DetailmovieBloc, DetailmovieState>(
        builder: (context, state) {
          if (state is Empty) {
            return _buildScaffoldNoData("empty", "");
          } else if (state is Loading) {
            return _buildScaffoldNoData("loading", "loading");
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
                              child: Image.network(
                                ApiService.baseUrlImage + state.data.posterPath,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 100,
                            left: 10,
                            right: 10,
                            child: FlutterShine(builder: (BuildContext context,
                                ShineShadow shineShadow) {
                              return Text(
                                state.data.title,
                                textAlign: TextAlign.center,
                                style: shineShadow.shadows != null
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
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 185),
                                Card(
                                  elevation: 1.7,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Trailers",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          height: 200,
                                          color: Colors.black,
                                          child:

                                              // VideoItems(
                                              //   videoPlayerController: VideoPlayerController.network(
                                              //       'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
                                              //   ),
                                              //   looping: false,
                                              //   autoplay: false,
                                              // ),

                                              BlocBuilder<video.MovievideoBloc,
                                                  video.MovievideoState>(
                                            builder: (context, stateVideo) {
                                              if (stateVideo is video.Empty) {
                                                return _buildTextVideo(
                                                    "Video tidak ada");
                                              } else if (stateVideo
                                                  is video.Loading) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else if (stateVideo
                                                  is video.Loaded) {
                                                // return VideoYoutube(
                                                //   videoKey: videoKey(stateVideo.result!.result!.),
                                                //   autoplay: false,);
                                                return VideoItems(
                                                  videoPlayerController:
                                                      VideoPlayerController
                                                          .network(videoUrl(
                                                              stateVideo.data)),
                                                  looping: false,
                                                  autoplay: false,
                                                );
                                              } else if (stateVideo
                                                  is video.Error) {
                                                return _buildTextVideo(
                                                    "Error " +
                                                        stateVideo.message);
                                              } else {
                                                return _buildTextVideo("Error");
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 460, left: 15, right: 15, bottom: 15),
                              child: Card(
                                elevation: 1.7,
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Text('Rating : ' +
                                          state.data.voteAverage.toString()),
                                      SizedBox(height: 10),
                                      Text('Bahasa : ' +
                                          (state.data.originalLanguage == "en"
                                              ? "english"
                                              : state.data.originalLanguage)),
                                      SizedBox(height: 10),
                                      Text('Budget : USD ' +
                                          state.data.budget.toString()),
                                      SizedBox(height: 10),
                                      Text('Tanggal rilis : ' +
                                          (state.data.releaseDate
                                                      .toString()
                                                      .length >
                                                  10
                                              ? state.data.releaseDate
                                                  .toString()
                                                  .substring(0, 10)
                                              : state.data.releaseDate
                                                  .toString())),
                                      SizedBox(height: 10),
                                      Text('Genre : ' +
                                          genreArrayToString(
                                              state.data.genres)),
                                      SizedBox(height: 10),
                                      Text('Detail : ' + state.data.overview),
                                    ],
                                  ),
                                ),
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
            return _buildScaffoldNoData(state.message, "");
          } else {
            return _buildScaffoldNoData("", "");
          }
        },
      ),
    );
  }

  Text _buildTextVideo(String message) {
    return Text(
      message,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Scaffold _buildScaffoldNoData(String message, String jenis) {
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
                    color: Colors.grey,
                  ),
                  Positioned(
                    top: 100,
                    left: 10,
                    right: 10,
                    child: FlutterShine(builder:
                        (BuildContext context, ShineShadow shineShadow) {
                      return Text(
                        "Detail Movie",
                        textAlign: TextAlign.center,
                        style: shineShadow.shadows != null
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
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 200, left: 15, right: 15, bottom: 15),
                      child: Card(
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
                              Container(
                                height: 200,
                                child: jenis == "loading"
                                    ? Text(
                                        message,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(),
                                      ),
                              ),
                            ],
                          ),
                        ),
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
  }

  String genreArrayToString(List<Genre> data) {
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

  String videoUrl(List<MovieVideo> data) {
    String hasil = "";
    for (int i = 0; i < data.length; i++) {
      if (data[i].site != "" && data[i].site != "null") {
        if (data[i].key != "" && data[i].key != "null") {
          if (hasil == "") {
            print("bayu 1 " + data[i].site.toLowerCase());
            if (data[i].site.toLowerCase() == "youtube") {
              hasil = ApiService.baseUrlYoutube + data[i].key;
            } else if (data[i].site.toLowerCase() == "vimeo") {
              hasil = ApiService.baseUrlVimeo + data[i].key;
            }
          }
        }
      }
    }
    print("bayu " + hasil);
    return hasil;
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
