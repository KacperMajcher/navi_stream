import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navi_stream/core/constants/constants.dart';
import 'package:navi_stream/features/home/pages/widgets/video_controls.dart';
import 'package:video_player/video_player.dart';

class ChannelPlayer extends StatefulWidget {
  const ChannelPlayer({super.key});

  @override
  ChannelPlayerState createState() => ChannelPlayerState();
}

class ChannelPlayerState extends State<ChannelPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    String decodeBase64(String base64String) {
      if (base64String.length % 4 != 0) {
        int padding = 4 - (base64String.length % 4);
        base64String =
            base64String.padRight(base64String.length + padding, '=');
      }

      return utf8.decode(base64.decode(base64String));
    }

    String decodedUrl = decodeBase64(playerBase64);
    final url = Uri.parse(kIsWeb
        ? 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
        : decodedUrl);

    log(kIsWeb
        ? '''Browsers in the current technological stack are unable to play the 
        decoded video format, so I'm providing a fallback video to display on the web. 
        If you want to see the original decoded video, please run a mobile emulator.'''
        : 'Welcome to the app, I have a specially decoded video for you.');

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
