import 'package:flutter/material.dart';
import 'package:glow/Resources.dart';
import 'Common.dart';
import 'FlyerList.dart';

class App extends StatelessWidget {
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
      home: FlyerListPage(),
    );
  }
}