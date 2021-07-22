// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class VideoYoutube extends StatefulWidget {
//
//   final String videoKey;
//   final bool autoplay;
//
//   VideoYoutube({
//     required this.videoKey,
//     this.autoplay,
//     Key key,
//   }) : super(key: key);
//
//   @override
//   _VideoYoutubeState createState() => _VideoYoutubeState();
// }
//
// class _VideoYoutubeState extends State<VideoYoutube> {
//
//   YoutubePlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: widget.videoKey,
//       flags: YoutubePlayerFlags(
//         autoPlay: widget.autoplay,
//         mute: true,
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayer(
//       controller: _controller,
//       showVideoProgressIndicator: true,
//       progressColors: ProgressBarColors(
//         playedColor: Colors.amber,
//         handleColor: Colors.amberAccent,
//       ),
//       // onReady: () {
//       //   _controller.addListener(listener);
//       // },
//     );
//   }
//
//
//
//
// }
//
//
//
