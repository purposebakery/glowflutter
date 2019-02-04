import 'package:flutter/material.dart';
import 'package:glow/colors.dart';
import 'package:glow/resources.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FlyerDetail extends StatelessWidget {
  FlyerDetail({this.flyerIndex});

  final int flyerIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAcent,
        title: Text('Detail'),
      ),
      body: WebView(
        initialUrl: new Uri.dataFromString(resources.flyers[flyerIndex].content, mimeType: 'text/html').toString(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}