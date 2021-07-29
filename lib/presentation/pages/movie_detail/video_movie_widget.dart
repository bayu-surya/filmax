import 'package:filmax/api_service.dart';
import 'package:filmax/domain/entities/movie_video.dart';
import 'package:filmax/presentation/bloc/movievideo/movievideo_bloc.dart'
    as video;
import 'package:filmax/presentation/widgets/video_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoMovieWidget extends StatelessWidget {
  const VideoMovieWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          return _buildTextVideo("Video tidak ada");
                        } else if (stateVideo is video.Loading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (stateVideo is video.Loaded) {
                          // return VideoYoutube(
                          //   videoKey: videoKey(stateVideo.result!.result!.),
                          //   autoplay: false,);
                          return VideoItems(
                            videoPlayerController:
                                VideoPlayerController.network(
                                    videoUrl(stateVideo.data)),
                            looping: false,
                            autoplay: false,
                          );
                        } else if (stateVideo is video.Error) {
                          return _buildTextVideo("Error " + stateVideo.message);
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
}
