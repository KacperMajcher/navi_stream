import 'package:flutter/material.dart';
import 'package:navi_stream/dependencies/injection_container.dart';
import 'package:navi_stream/app/app.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}
