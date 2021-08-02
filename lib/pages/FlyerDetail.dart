import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:glow/model/Flyer.dart';
import 'package:glow/model/Resources.dart';
import 'package:glow/utils/External.dart';
import 'package:glow/utils/Utils.dart';
import 'package:html/dom.dart' as dom;

import '../Common.dart';

class FlyerDetailPage extends StatefulWidget {
  FlyerDetailPage(this.flyerId) : super(key: new ValueKey(flyerId));
  final String flyerId;

  @override
  FlyerDetailPageState createState() {
    return FlyerDetailPageState(Resources().flyerMap[flyerId]!);
  }
}

class FlyerDetailPageState extends State<FlyerDetailPage> {
  FlyerDetailPageState(this.flyer) : super();
  final Flyer flyer;

  @override
  Widget build(BuildContext context) {
    Utils.initializeDynamicSizes(context);

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            createAppBar(),
            createContent()
          ],
        )
    );
  }

  Widget createAppBar() {
    return SliverAppBar(
      brightness: Brightness.dark,
      pinned: true,
      expandedHeight: 160.0 * Utils.DYNAMIC_SCALE,
      flexibleSpace: FlexibleSpaceBar(
        title: createAppBarTitle(),
        background: createAppBarBackground(),
      ),
    );
  }

  Widget createAppBarTitle() {
    var title = flyer.titleShort;
    if (Utils.DYNAMIC_SCALE > 1.3) {
      title = flyer.title;
    }
    return Padding(
        padding: EdgeInsets.only(left : Utils.SPACE1_D),
        child: Text(title, style: TextStyle(fontSize: Utils.TEXT_LARGE_D))
    );
  }

  Widget createAppBarBackground() {
    var cover = flyer.cover;
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.grey.withAlpha(150),
        BlendMode.dstATop,
      ),
      child: Image.asset(cover, fit: BoxFit.fitWidth),
    );
  }

  Widget createContent() {
    return SliverToBoxAdapter(child:  FutureBuilder<String>(
        future: flyer.loadContent(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return getUiForLoaded(snapshot.data!);
          } else {
            return getUiForEmpty();
          }
        })
      );
  }

  Widget getUiForEmpty() {
    return CircularProgressIndicator();
  }

  Widget getUiForLoaded(String html) {
    return getContent(html);
  }

  Widget getContent(String html) {
    return SingleChildScrollView(child: getFlyerText(html));
  }

  Widget getFlyerText(String html) {
    return Padding(
        padding: EdgeInsets.all(Utils.SPACE1_D),
        child: Html(
          data: html,
          style: {
            "body": Style(
              fontSize: FontSize(Utils.TEXT_MEDIUM_D)
            ),
          },
          customImageRenders: getCustomImageRenders(),
          onLinkTap: (url, context, attributes, element) => External.launchURL(url),
        ));
  }

  Map<ImageSourceMatcher, ImageRender> getCustomImageRenders() {
    var customRender = HashMap<ImageSourceMatcher, ImageRender>();
    customRender[flyerAssetUriMatcher] = flyerAssetImageRender;
    return customRender;
  }

  bool flyerAssetUriMatcher(Map<String, String> attributes, dom.Element? element) {
    var src = attributes['src'];
    return src != null ? src.contains('image') : false;
  }

  Widget? flyerAssetImageRender(
    RenderContext context,
    Map<String, String> attributes,
    dom.Element? element,
  ) {
    return Padding(padding: EdgeInsets.all(Utils.SPACE1_D), child: new Image.asset("${CommonPaths.FLYER}${flyer.id}${attributes["src"]}"));
  }
}
