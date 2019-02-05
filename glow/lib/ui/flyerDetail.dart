import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glow/io/localloader.dart';
import 'package:glow/ui/data/colors.dart';
import 'package:glow/ui/data/resources.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FlyerDetail extends StatelessWidget {
  FlyerDetail({this.flyerIndex});

  final int flyerIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAcent,
        title: Text(resources.flyers[flyerIndex].title),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset(resources.flyers[flyerIndex].cover, width: 100, height: 100, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AssetWebview(asset: resources.flyers[flyerIndex].content),
          ),
        ],
      ),
    );
  }


}

class AssetWebview extends StatelessWidget {

  AssetWebview({this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: LocalLoader().loadLocal(asset),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WebView(
              initialUrl: new Uri.dataFromString(snapshot.data, mimeType: 'text/html', encoding: Encoding.getByName("UTF-8")).toString(),
              javascriptMode: JavascriptMode.unrestricted,
            );

          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        }
    );
  }
}