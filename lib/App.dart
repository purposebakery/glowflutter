import 'package:flutter/material.dart';
import 'package:glow/model/Resources.dart';

import 'Common.dart';
import 'pages/FlyerList.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Resources().init();

    return MaterialApp(
      title: 'Glow',
      theme: ThemeData(
          iconTheme: IconThemeData(color: CommonColors.primary),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          primaryColor: CommonColors.primary
      ),
      darkTheme: ThemeData(
          iconTheme: IconThemeData(color: Colors.white),
          brightness: Brightness.dark,
          backgroundColor: Colors.grey.shade900,
          primaryColor: CommonColors.primary),
      home: FlyerListPage(),
    );
  }
}
