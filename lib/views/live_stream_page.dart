//lib/views/live_stream_page.dart
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LiveStreamPage extends StatelessWidget {
  LiveStreamPage({super.key});
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'BPk4BGhJyHg',
    flags: YoutubePlayerFlags(autoPlay: false, isLive: true),
  );
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        bool isLandscape = orientation == Orientation.landscape;
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        // Determine the size of the video based on orientation
        double videoWidth = screenWidth;
        double videoHeight = isLandscape
            ? screenHeight
            : screenHeight * 0.56; // typical aspect ratio for videos

        return Scaffold(
          body: Container(
            color: Colors.black,
            alignment: isLandscape ? Alignment.center : Alignment.topCenter,
            child: SizedBox(
                width: videoWidth,
                height: videoHeight,
                child: YoutubePlayer(
                  controller: _controller,
                )),
          ),
        );
      },
    );
  }
}
