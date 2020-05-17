import 'package:flutter/material.dart';
import 'package:wallty_app/screens/myHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper App',
      routes: {
        "/": (context) => MyHomePage(),
      },
      initialRoute: "/",
    );
  }
}
