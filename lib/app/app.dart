import 'package:flutter/material.dart';
import 'package:navi_stream/core/config.dart';
import 'package:navi_stream/features/auth/presentation/pages/welcome_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WelcomePage(),
      debugShowCheckedModeBanner: Config.debugShowCheckedModeBanner,
    );
  }
}
