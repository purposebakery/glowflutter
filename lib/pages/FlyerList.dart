import 'package:flutter/material.dart';
import 'package:glow/model/Resources.dart';
import 'package:glow/pages/FlyerDetail.dart';
import 'package:glow/utils/External.dart';

import '../Common.dart';

class FlyerListPage extends StatefulWidget {
  FlyerListPage({Key? key}) : super(key: key);

  @override
  FlyerListPageState createState() => FlyerListPageState();
}

class FlyerListPageState extends State<FlyerListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: createAppBar(), drawer: createDrawer(), body: createBody());
  }

  AppBar createAppBar() {
    return AppBar(
        // status bar color
        brightness: Brightness.dark,
        title: Text("Glow"));
  }

  Widget createBody() {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 24,
      children: List.generate(Resources().flyers.length, (flyerIndex) {
        return Center(
          child: Card(
              elevation: 12,
              child: Stack(
                children: <Widget>[
                  Image.asset(resources.flyers[flyerIndex].cover),
                  Positioned.fill(
                      child: new Material(
                          color: Colors.transparent,
                          child: new InkWell(
                            splashColor: CommonColors.primary.withAlpha(150),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FlyerDetailPage(resources.flyers[flyerIndex].id)),
                              );
                            },
                          ))),
                ],
              )),
        );
      }),
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
          leading: Icon(CommonIconsDyn.home, color: CommonColors.primary),
          title: Text("Homepage")),
      ListTile(
          onTap: () {
            External.launchURL(CommonStrings.shop_url);
          },
          leading: Icon(CommonIconsDyn.shop, color: CommonColors.primary),
          title: Text("Shop")),
      Divider(color: Colors.grey),
      ListTile(
          onTap: () {
            showContact(context);
          },
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
