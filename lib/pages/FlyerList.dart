import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glow/Common.dart';
import 'package:glow/model/Flyer.dart';
import 'package:glow/model/Resources.dart';
import 'package:glow/pages/FlyerDetail.dart';
import 'package:glow/utils/External.dart';
import 'package:glow/utils/Utils.dart';

class FlyerListPage extends StatefulWidget {
  FlyerListPage({Key? key}) : super(key: key);

  @override
  FlyerListPageState createState() => FlyerListPageState();
}

class FlyerListPageState extends State<FlyerListPage> {
  @override
  Widget build(BuildContext context) {
    Utils.initialize(context);

    return Scaffold(appBar: createAppBar(), drawer: createDrawer(), body: createBody());
  }

  AppBar createAppBar() {
    return AppBar(
        // status bar color
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text("GLOW Deutschland"));
  }

  Widget createBody() {
    var displayWidth = Utils.getDisplaySizeWidth(context);
    var spacing = Utils.SPACE1_D;
    var flyerWidth = Utils.SPACE4_D * 2;
    var horizontalCount = (displayWidth - spacing) ~/ (flyerWidth + spacing);

    flyerWidth = (displayWidth - (spacing + spacing * horizontalCount)) / horizontalCount;

    return GridView.count(
        padding: EdgeInsets.symmetric(vertical: spacing),
        crossAxisCount: horizontalCount.toInt(),
        mainAxisSpacing: Utils.SPACE2_D,
        children: createFlyerList()
    );
  }

  List<Widget> createFlyerList() {
    return List.generate(Resources().flyers.length, (flyerIndex) {
      return createFlyer(resources.flyers[flyerIndex]);
    });
  }

  Widget createFlyer(Flyer flyer) {
    return Center(
      child: Card(
          elevation: 12,
          child: Stack(
            children: <Widget>[
              Image.asset(flyer.cover),
              Positioned.fill(
                  child: new Material(
                      color: Colors.transparent,
                      child: new InkWell(
                        splashColor: CommonColors.primary.withAlpha(150),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FlyerDetailPage(flyer.id)),
                          );
                        },
                      )
                  )
              ),
            ],
          )),
    );
  }

  Drawer createDrawer() {
    return Drawer(
        child: ListView(
            padding: EdgeInsets.zero, children: <Widget>[
      DrawerHeader(
          child: Image.asset("${CommonPaths.DA}glow_logo_vertical_white.png"),
          decoration: BoxDecoration(color: CommonColors.primary)),
      ListTile(
          onTap: () {
            External.launchURL(context, CommonStrings.homepage_url);
          },
          leading: createDrawerIcon(CommonIconsDyn.home),
          title: Text("Homepage")),
      ListTile(
          onTap: () {
            External.launchURL(context, CommonStrings.shop_url);
          },
          leading: createDrawerIcon(CommonIconsDyn.shop),
          title: Text("Shop")),
      ListTile(
          onTap: () {
            External.shareText(context, CommonStrings.app_url);
          },
          leading: createDrawerIcon(CommonIconsDyn.share),
          title: Text("App Teilen")),
      Divider(color: getDrawerIconColor().withAlpha(150)),
      ListTile(
          onTap: () {
            showContact(context);
          },
          leading: createDrawerIcon(CommonIconsDyn.contact),
          title: Text("Kontakt")),
    ]));
  }

  void showContact(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Wrap(children: <Widget>[
              Column(
                children: <Widget>[
                  ListTile(
                      onTap: () {
                        External.launchURL(context, CommonStrings.email_uri);
                      },
                      leading: createDrawerIcon(CommonIconsDyn.mail),
                      title: Text("E-Mail")),
                  ListTile(
                      onTap: () {
                        External.launchURL(context, CommonStrings.phone_uri);
                      },
                      leading: createDrawerIcon(CommonIconsDyn.phone),
                      title: Text("Telefon")),
                ],
              )
            ]));
  }

  Icon createDrawerIcon(IconData iconData) {
    return Icon(iconData, color: getDrawerIconColor());
  }

  Color getDrawerIconColor() {
    if (Utils.DARK_THEME_ENABLED) {
      return Colors.white;
    } else {
      return CommonColors.primary;
    }
  }
}
