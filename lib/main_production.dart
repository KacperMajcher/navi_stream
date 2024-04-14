import 'package:flutter/material.dart';
import 'package:navi_stream/core/config.dart';
import 'package:navi_stream/dependencies/injection_container.dart';
import 'package:navi_stream/app/app.dart';

void main() {
  Config.appFlavor = Flavor.production;
  configureDependencies();
  runApp(const MyApp());
}
