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
      theme: ThemeData(brightness: Brightness.light, backgroundColor: Colors.white, primaryColor: CommonColors.primary),
      darkTheme: ThemeData(brightness: Brightness.dark, backgroundColor: Colors.grey.shade800, primaryColor: CommonColors.primary),
      home: FlyerListPage(),
    );
  }
}
