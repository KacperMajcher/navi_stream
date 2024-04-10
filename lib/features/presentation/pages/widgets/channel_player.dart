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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 50.0),
          ),
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(_controller),
                VideoProgressIndicator(_controller, allowScrubbing: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
