//lib/views/live_stream_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class LiveStreamPage extends StatelessWidget {
  const LiveStreamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        bool isLandscape = orientation == Orientation.landscape;
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        // Determine the size of the video based on orientation
        double videoWidth = screenWidth;
        double videoHeight = isLandscape ? screenHeight : screenHeight * 0.56; // typical aspect ratio for videos

        return Scaffold(
          body: Container(
            color: Colors.black,
            alignment: isLandscape ? Alignment.center : Alignment.topCenter,
            child: SizedBox(
              width: videoWidth,
              height: videoHeight,
              child: HtmlWidget(
                '''
                  <iframe 
                    src="https://cust-kloster-einsiedeln-front-9b2d91cc913e.herokuapp.com/embed" 
                    width="100%"
                    height="100%"
                    frameborder="0" 
                    allow="autoplay; encrypted-media; fullscreen"
                    allowfullscreen
                    style="border-radius: 0px;"
                  ></iframe>
                ''',
              ),
            ),
          ),
        );
      },
    );
  }
}
