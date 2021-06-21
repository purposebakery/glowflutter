import 'package:flutter/material.dart';
import 'package:glow/resources.dart';
import 'common.dart';
import 'flyerList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Resources().init();

    return MaterialApp(
      title: 'Glow',
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        primaryColor: Common.primary
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
          backgroundColor: Colors.grey.shade800,
          primaryColor: Common.primary
      ),
      home: FlyerListPage(title: 'Glow'),
    );
  }
}