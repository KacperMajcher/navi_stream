import 'package:flutter/material.dart';
import 'package:navi_stream/features/presentation/pages/channel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Channels'),
      ),
      body: const Center(
        child: Column(
          children: [
            Text(
              'Welcome to the application, you have logged in.\nThats your channels',
              textAlign: TextAlign.center,
            ),
            Channel(
              channelName: 'Canal+ Sport',
              channelLogo: 'assets/logo_test.jpg',
            )
          ],
        ),
      ),
    );
  }
}
