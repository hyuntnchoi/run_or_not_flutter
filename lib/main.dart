import 'package:flutter/material.dart';
import 'subway.dart';
import 'location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var location = new Location();
    location.printPosition();

    return MaterialApp(
      title: '뛸까말까',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Subway(),
    );
  }
}