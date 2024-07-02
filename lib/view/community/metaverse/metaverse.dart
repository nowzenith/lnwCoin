import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Metaverse extends StatefulWidget {
  const Metaverse({super.key});

  @override
  State<Metaverse> createState() => _MetaverseState();
}

class _MetaverseState extends State<Metaverse> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset('assets/videos/metaverse.mp4');

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
    _controller.play();

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 350,
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the VideoPlayer.
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        SizedBox(
          height: 50,
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Color.fromARGB(194, 170, 0, 28),
            shape: StadiumBorder(),
            side: BorderSide(width: 2, color: Color.fromARGB(194, 170, 0, 28)),
          ),
          onPressed: null,
          child: Text(
            "Login to Metaverse",
            style: TextStyle(color: Colors.grey),
          ),
        )
      ],
    );
  }
}
