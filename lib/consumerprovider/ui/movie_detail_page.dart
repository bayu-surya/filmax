import 'package:filmax/consumerprovider/data/api/api_service.dart';
import 'package:filmax/consumerprovider/data/model/detail_movie.dart';
import 'package:filmax/consumerprovider/data/model/movie_video.dart';
import 'package:filmax/consumerprovider/provider/detailmovie_provider.dart';
import 'package:filmax/consumerprovider/provider/movievideo_provider.dart';
import 'package:filmax/consumerprovider/utils/result_state.dart' as resultS;
import 'package:filmax/consumerprovider/widgets/video_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shine/flutter_shine.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../core/common/styles.dart';

class MovieDetailPage extends StatelessWidget {
  static const routeName = '/movie_detail';

  final String id;

  const MovieDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    if (id != "") {
      Provider.of<DetailMovieProvider>(context, listen: false)
          .fetchAllArticle(id.toString());
      Provider.of<MovieVideoProvider>(context, listen: false)
          .fetchAllArticle(id.toString());
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: primaryBarColor,
      ),
      child: Consumer<DetailMovieProvider>(
        builder: (context, state, _) {
          if (state.state == resultS.ResultState.Loading) {
            return _buildScaffoldNoData(state.message, "loading");
          } else if (state.state == resultS.ResultState.HasData) {
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
                              tag: state.result!.id,
                              child: Image.network(
                                ApiService.baseUrlImage +
                                    state.result!.posterPath,
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
                                state.result!.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  shadows: shineShadow.shadows,
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

                                              Consumer<MovieVideoProvider>(
                                                  builder:
                                                      (context, stateVideo, _) {
                                            if (stateVideo.state ==
                                                resultS.ResultState.Loading) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (stateVideo.state ==
                                                resultS.ResultState.HasData) {
                                              // return VideoYoutube(
                                              //   videoKey: videoKey(stateVideo.result!.result!.),
                                              //   autoplay: false,);
                                              return VideoItems(
                                                videoPlayerController:
                                                    VideoPlayerController
                                                        .network(videoUrl(
                                                            stateVideo.result!
                                                                .results)),
                                                looping: false,
                                                autoplay: false,
                                              );
                                            } else if (stateVideo.state ==
                                                resultS.ResultState.NoData) {
                                              return _buildTextVideo(
                                                  "Video tidak ada");
                                            } else if (stateVideo.state ==
                                                resultS.ResultState.Error) {
                                              return _buildTextVideo("Error " +
                                                  stateVideo.message);
                                            } else {
                                              return _buildTextVideo("Error");
                                            }
                                          }),
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
                                          state.result!.voteAverage.toString()),
                                      SizedBox(height: 10),
                                      Text('Bahasa : ' +
                                          (state.result!.originalLanguage ==
                                                  "en"
                                              ? "english"
                                              : state
                                                  .result!.originalLanguage)),
                                      SizedBox(height: 10),
                                      Text('Budget : USD ' +
                                          state.result!.budget.toString()),
                                      SizedBox(height: 10),
                                      Text('Tanggal rilis : ' +
                                          (state.result!.releaseDate
                                                      .toString()
                                                      .length >
                                                  10
                                              ? state.result!.releaseDate
                                                  .toString()
                                                  .substring(0, 10)
                                              : state.result!.releaseDate
                                                  .toString())),
                                      SizedBox(height: 10),
                                      Text('Genre : ' +
                                          genreArrayToString(
                                              state.result!.genres)),
                                      SizedBox(height: 10),
                                      Text(
                                          'Detail : ' + state.result!.overview),
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
          } else if (state.state == resultS.ResultState.NoData) {
            return _buildScaffoldNoData(state.message, "");
          } else if (state.state == resultS.ResultState.Error) {
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
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          shadows: shineShadow.shadows,
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

  String videoUrl(List<Result> data) {
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

  String videoKey(List<Result> data) {
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
