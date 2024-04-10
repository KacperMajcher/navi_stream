import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  bool _fullScreen = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(url);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();

    log(kIsWeb
        ? 'Welcome in the web, I\'ll play a link with a browser-supported format.'
        : 'Welcome to the app, I have a specially decoded video for you.');
  }

  @override
  Widget build(BuildContext context) {
    final double dh = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: dh * .05),
          ),
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(_controller),
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                ),
                VideoControls(
                  controller: _controller,
                  isFullScreen: _fullScreen,
                  toggleFullScreen: () {
                    setState(() {
                      _fullScreen = !_fullScreen;
                    });

                    if (_fullScreen) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => Scaffold(
                            body: Center(
                              child: AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                    VideoPlayer(_controller),
                                    VideoProgressIndicator(
                                      _controller,
                                      allowScrubbing: true,
                                    ),
                                    VideoControls(
                                      controller: _controller,
                                      isFullScreen: _fullScreen,
                                      toggleFullScreen: () {
                                        setState(() {
                                          _fullScreen = !_fullScreen;
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class VideoControls extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isFullScreen;
  final VoidCallback toggleFullScreen;

  const VideoControls({
    required this.controller,
    required this.isFullScreen,
    required this.toggleFullScreen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          bottom: 0,
          child: IconButton(
            icon: Icon(
              isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
              color: Colors.white,
            ),
            onPressed: toggleFullScreen,
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
      ],
    );
  }
}
