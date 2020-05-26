import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glow/external.dart';
import 'package:glow/flyer.dart';
import 'package:glow/resources.dart';
import 'package:html/dom.dart' as dom;

import 'common.dart';

class FlyerDetailPage extends StatefulWidget {
  FlyerDetailPage({this.flyerId}) : super(key: new ValueKey(flyerId));
  final String flyerId;

  @override
  FlyerDetailPageState createState() =>
      FlyerDetailPageState(flyer: Resources().flyerMap[flyerId]);
}

class FlyerDetailPageState extends State<FlyerDetailPage> {
  FlyerDetailPageState({this.flyer}) : super();
  final Flyer flyer;
  Html html;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: createAppBar(), body: createBody());
  }

  AppBar createAppBar() {
    return AppBar(
      title: Text(flyer.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(IconsDyn.share),
          tooltip: 'Share',
          onPressed: () {
            External.launchURL(flyer.url);
          },
        )
      ],
    );
  }

  Widget createBody() {
    return FutureBuilder<String>(
        future: flyer.loadContent(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          print("loaded data");
          print(snapshot.data);
          if (snapshot.hasData) {
            return getUiForLoaded(snapshot.data);
          } else {
            return getUiForEmpty();
          }
        });
  }

  Widget getUiForEmpty() {
    return CircularProgressIndicator();
  }

  Widget getUiForLoaded(String html) {
    return SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(16), child: Html(
          data: html,
          customRender: getCustomRender(),
          onLinkTap: (link) => External.launchURL(link),
        ))
    );
  }

  Map<String, CustomRender> getCustomRender() {
    var customRender = HashMap<String, CustomRender>();
    customRender["img"] = getImageCustomRender;
    return customRender;
  }

  Widget getImageCustomRender(RenderContext context,
      Widget parsedChild,
      Map<String, String> attributes,
      dom.Element element) {
        return Padding(padding: EdgeInsets.all(24),child: new Image.asset("$FLYER${flyer.id}${attributes["src"]}"));
  }
}
