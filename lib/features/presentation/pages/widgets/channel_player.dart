import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navi_stream/core/constants/constants.dart';
import 'package:video_player/video_player.dart';

class ChannelPlayer extends StatefulWidget {
  const ChannelPlayer({super.key});

  @override
  ChannelPlayerState createState() => ChannelPlayerState();
}

String decodedUrl = utf8.decode(base64.decode(playerBase64));
final url = Uri.parse(kIsWeb
    ? 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
    : decodedUrl);

/*
D E C O D I N G
The web does not support the decoded link format.
When opening in the browser, display the link in .mp4 format.
In the case of a mobile application, display the decoded video.
*/

class ChannelPlayerState extends State<ChannelPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );

    _controller = VideoPlayerController.networkUrl(url)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then(
        (_) => setState(
          () => _controller.play(),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _controller.value.isInitialized
            ? Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  VideoControls(
                    controller: _controller,
                    onBack: () => Navigator.of(context).pop(),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controller.dispose();
    super.dispose();
  }
}

class VideoControls extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onBack;
  const VideoControls({
    Key? key,
    required this.controller,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 20,
          left: 20,
          child: InkWell(
            onTap: onBack,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.black45,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Center(
          child: IconButton(
            icon: Icon(
              controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () {
              if (controller.value.isPlaying) {
                controller.pause();
              } else {
                controller.play();
              }
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: VideoProgressIndicator(
            controller,
            allowScrubbing: true,
            padding: const EdgeInsets.only(bottom: 8),
          ),
        ),
      ],
    );
  }
}
