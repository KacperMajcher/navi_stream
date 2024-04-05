import 'package:flutter/material.dart';
import 'package:navi_stream/app/injection_container.dart';
import 'package:navi_stream/core/app.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}
