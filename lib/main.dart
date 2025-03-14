import 'package:flutter/material.dart';
import 'package:world_time/page/choose_location.dart';
import 'package:world_time/page/loading.dart';
import 'package:world_time/page/home.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/location': (context) => ChooseLocation(),
      },
    ),
  );
}
