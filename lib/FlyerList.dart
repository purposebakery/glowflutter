import 'package:flutter/material.dart';
import 'package:glow/External.dart';
import 'package:glow/FlyerDetail.dart';
import 'package:glow/Resources.dart';

import 'Common.dart';

class FlyerListPage extends StatefulWidget {
  FlyerListPage({Key? key}) : super(key: key);

  @override
  FlyerListPageState createState() => FlyerListPageState();
}

class FlyerListPageState extends State<FlyerListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(),
      drawer: createDrawer(),
      body: createBody()
    );
  }

  AppBar createAppBar() {
    return AppBar(
      title: Text("Glow")
    );
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
                              splashColor: Common.primary,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FlyerDetailPage(resources.flyers[flyerIndex].id)
                                  ),
                                );
                              },
                            )
                        )
                    ),
                  ],
                )),
          );
        }),
      );
  }

  Drawer createDrawer() {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero,children: <Widget>[
          DrawerHeader(
            child: Image.asset("${DA}glow_logo_vertical_white.png"),
            decoration: BoxDecoration(
              color: Common.primary
            )
          ),
          ListTile(
              onTap: () {
                External.launchURL(Common.homepage_url);
              },
              leading: Icon(IconsDyn.home),
              title: Text("Homepage")),
          ListTile(
              onTap: () {
                External.launchURL(Common.shop_url);
              },
              leading: Icon(IconsDyn.shop),
              title: Text("Shop")),
          Divider(color: Colors.grey),
          /*
          ListTile(
              onTap: () {
                External.shareText(Common.app_url);
              },
              title: Text("App teilen")
          ),*/
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
                        External.launchURL(Common.email_uri);
                      },
                      leading: Icon(IconsDyn.mail),
                      title: Text("E-Mail")),
                  ListTile(
                      onTap: () {
                        External.launchURL(Common.phone_uri);
                      },
                      leading: Icon(IconsDyn.phone),
                      title: Text("Telefon")),
                ],
              )
            ]));
  }
}
