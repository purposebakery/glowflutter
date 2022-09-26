import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:glow/model/Flyer.dart';
import 'package:glow/model/Resources.dart';
import 'package:glow/storage/FavouriteStore.dart';
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
  ScrollController scrollController  = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Utils.initialize(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: scrollController,
            slivers: [
              createAppBar(),
              createContent(),
            ],
          ),
          Align(
              child: createFab()),
        ],
      ),
    );
    /*
    return Scaffold(
        body: SliverFab(
          floatingWidget: FloatingActionButton(
            onPressed: () =>
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("You clicked FAB!"))),
            backgroundColor: CommonColors.red,
            child: Icon(Icons.favorite),
          ),
          floatingPosition: FloatingPosition(right: 16),
          expandedHeight: 256.0,
          slivers: [
            createAppBar(),
            createContent(),

          ],
        )
    );*/
  }

  Widget createAppBar() {
    return SliverAppBar(
      backgroundColor: CommonColors.primary,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      pinned: true,
      actions: createAppBarActions(),
      expandedHeight: 256,
      flexibleSpace: FlexibleSpaceBar(
        title: createAppBarTitle(),
        background: createAppBarBackground(),
      ),
    );
  }

  List<Widget> createAppBarActions() {
    List<Widget> actions = List.empty(growable: true);

    actions.add(FutureBuilder<bool>(
        future: FavouriteStore.isFavourite(flyer.id),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data != null && snapshot.data!) {
            return IconButton(
              icon: Icon(CommonIconsDyn.favouriteActivated),
              onPressed : removeFromFavourites,
            );
          } else {
            return IconButton(
              icon: Icon(CommonIconsDyn.favouriteDeactivated),
              onPressed : addToFavourites,
            );

          }
        }));

    return actions;
  }

  void removeFromFavourites() {
    setState(() {
      FavouriteStore.removeFavourite(flyer.id);
    });
  }

  void addToFavourites() {
    setState(() {
      FavouriteStore.addFavourite(flyer.id);
    });
  }

  void onSharePressed() {
    External.shareText(context, flyer.url);
  }

  Widget createAppBarTitle() {
    var title = flyer.title;
    if (Platform.isIOS && Utils.DYNAMIC_SCALE <= 1.3) {
        title = flyer.titleShort;
    }
    return Padding(
        padding: EdgeInsets.only(right : Utils.SPACE3_D),
        child: Text(title, style: TextStyle(fontSize: Utils.TEXT_MEDIUM_D))
    );
  }

  Widget createAppBarBackground() {
    var cover = flyer.cover;
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.grey.withAlpha(100),
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
    return getFlyerText(html);
  }

  Widget getFlyerText(String html) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.all(Utils.SPACE1_D),
            child: Html(
              data: html,
              style: {
                /*
                "a": Style(
                    textDecoration : TextDecoration.underline,
                    textDecorationColor: CommonColors.primary,
                    textDecorationStyle: TextDecorationStyle.solid,
                    color : CommonColors.primary,
                    fontSize: FontSize(Utils.TEXT_MEDIUM)
                ),*/
                "body": Style(fontSize: FontSize(Utils.TEXT_MEDIUM)),
              },
              customImageRenders: getCustomImageRenders(),
              onLinkTap: (url, context, attributes, element) => External.launchURL(this.context, url),
            )
        ),
        Padding(
          padding: EdgeInsets.only(bottom : Utils.SPACE1_D),
          child: ElevatedButton(
              child: Padding(
                padding: EdgeInsets.only(left : Utils.SPACE1_D, right : Utils.SPACE1_D),
                child: Text("Teilen"),
              ),
              onPressed: onSharePressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(CommonColors.primary),
              )
          ),
        )
      ],
    );
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


  final double expandedHeight = 256.0;
  final double topScalingEdge = 96.0;
  final FloatingPosition floatingPosition = const FloatingPosition(right: 16.0);

  Widget createFab() {
    final double defaultFabSize = 56.0;
    final double paddingTop = MediaQuery.of(context).padding.top;
    final double defaultTopMargin = expandedHeight +
        paddingTop + (floatingPosition.top) -
        defaultFabSize / 2;

    final double scale0edge = expandedHeight - kToolbarHeight;
    final double scale1edge = defaultTopMargin - topScalingEdge;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      top -= offset > 0 ? offset : 0;
      if (offset < scale1edge) {
        scale = 1.0;
      } else if (offset > scale0edge) {
        scale = 0.0;
      } else {
        scale = (scale0edge - offset) / (scale0edge - scale1edge);
      }
    }

    return Positioned(
      top: top,
      right: floatingPosition.right,
      left: floatingPosition.left,
      child: new Transform(
        transform: new Matrix4.identity()..scale(scale, scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          onPressed: () =>
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text("You clicked FAB!"))),
          backgroundColor: CommonColors.white,
          child: Icon(Icons.favorite, color: CommonColors.red,),
        ),
      ),
    );
  }


}

///A class representing position of the widget.
///At least one value should be not null
class FloatingPosition {
  ///Can be negative. Represents how much should you change the default position.
  ///E.g. if your widget is bigger than normal [FloatingActionButton] by 20 pixels,
  ///you can set it to -10 to make it stick to the edge
  final double top;

  ///Margin from the right. Should be positive.
  ///The widget will stretch if both [right] and [left] are not nulls.
  final double right;

  ///Margin from the left. Should be positive.
  ///The widget will stretch if both [right] and [left] are not nulls.
  final double left;

  const FloatingPosition({this.top = 0, this.right = 0, this.left = 0});
}