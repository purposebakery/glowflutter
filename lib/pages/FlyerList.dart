import 'package:flutter/material.dart';
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
    Utils.initializeDynamicSizes(context);

    return Scaffold(appBar: createAppBar(), drawer: createDrawer(), body: createBody());
  }

  AppBar createAppBar() {
    return AppBar(
        // status bar color
        brightness: Brightness.dark,
        title: Text("Glow"));
  }

  Widget createBody() {
    var displayWidth = Utils.getDisplaySizeWidth(context);
    var spacing = Utils.SPACE1_D;
    var flyerWidth = Utils.SPACE4_D * 2;
    var horizontalCount = (displayWidth - spacing) / (flyerWidth + spacing);

    return GridView.count(
        padding: EdgeInsets.symmetric(vertical: spacing * 2),
        crossAxisCount: horizontalCount.toInt(),
        mainAxisSpacing: spacing * 2,
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
                      ))),
            ],
          )),
    );
  }

  Drawer createDrawer() {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      DrawerHeader(
          child: Image.asset("${CommonPaths.DA}glow_logo_vertical_white.png"),
          decoration: BoxDecoration(color: CommonColors.primary)),
      ListTile(
          onTap: () {
            External.launchURL(CommonStrings.homepage_url);
          },
          leading: Icon(CommonIconsDyn.home),
          title: Text("Homepage")),
      ListTile(
          onTap: () {
            External.launchURL(CommonStrings.shop_url);
          },
          leading: Icon(CommonIconsDyn.shop),
          title: Text("Shop")),
      ListTile(
          onTap: () {
            External.shareText(CommonStrings.app_url);
          },
          leading: Icon(CommonIconsDyn.share),
          title: Text("App Teilen")),
      Divider(color: Colors.grey),
      ListTile(
          onTap: () {
            showContact(context);
          },
          leading: Icon(CommonIconsDyn.contact),
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
                        External.launchURL(CommonStrings.email_uri);
                      },
                      leading: Icon(CommonIconsDyn.mail, color: CommonColors.primary),
                      title: Text("E-Mail")),
                  ListTile(
                      onTap: () {
                        External.launchURL(CommonStrings.phone_uri);
                      },
                      leading: Icon(CommonIconsDyn.phone, color: CommonColors.primary),
                      title: Text("Telefon")),
                ],
              )
            ]));
  }
}
