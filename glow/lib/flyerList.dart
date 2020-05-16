import 'package:flutter/material.dart';
import 'package:glow/external.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glow/resources.dart';

import 'common.dart';

class FlyerListPage extends StatefulWidget {
  FlyerListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  FlyerListPageState createState() => FlyerListPageState();
}

class FlyerListPageState extends State<FlyerListPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(),
      drawer: createDrawer(),
//      body: GridView.count(
//        crossAxisCount: 2,
//        mainAxisSpacing: 24,
//        children: List.generate(resources.flyers.length, (flyerIndex) {
//          return Center(
//            child: Card(
//                elevation: 12,
//                child: Stack(
//                  children: <Widget>[
//                    Image.asset(resources.flyers[flyerIndex].cover),
//                    Positioned.fill(
//                        child: new Material(
//                            color: Colors.transparent,
//                            child: new InkWell(
//                              splashColor: colorAcentSlash,
//                              onTap: () {
//                                Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => FlyerDetail(flyerIndex: flyerIndex)),
//                                );
//                              },
//                            )
//                        )
//                    ),
//                  ],
//                )),
//          );
//        }),
//      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  AppBar createAppBar() {
    return AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.share),
          tooltip: 'Share',
          onPressed: () {
            Fluttertoast.showToast(msg: "This is Center Short Toast");
          },
        )
      ],
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
                              splashColor: Common.accent,
                              onTap: () {
//                                Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => FlyerDetail(flyerIndex: flyerIndex)),
//                                );
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
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          DrawerHeader(
            child: Image.asset("glow_logo_vertical_white.png"),
            decoration: BoxDecoration(
                color: Common.orange,
                image: DecorationImage(
                    image: AssetImage("background.png"), fit: BoxFit.cover)),
          ),
          ListTile(
              onTap: () {
                External.launchURL(Common.homepage_url);
              },
              leading: Image.asset("baseline_public_black_24dp.png"),
              title: Text("Homepage")),
          ListTile(
              onTap: () {
                External.launchURL(Common.shop_url);
              },
              leading: Image.asset("baseline_shopping_cart_black_24.png"),
              title: Text("Shop besuchen")),
          Divider(color: Colors.grey),
          ListTile(
              onTap: () {
                External.shareText(Common.app_url);
              },
              title: Text("App teilen")
          ),
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
                      leading: Image.asset("baseline_mail_black_24.png"),
                      title: Text("E-Mail")),
                  ListTile(
                      onTap: () {
                        External.launchURL(Common.phone_uri);
                      },
                      leading: Image.asset("baseline_phone_black_24.png"),
                      title: Text("Telefon")),
                ],
              )
            ]));
  }
}
