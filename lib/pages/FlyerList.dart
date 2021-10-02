import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glow/Common.dart';
import 'package:glow/model/Flyer.dart';
import 'package:glow/model/Resources.dart';
import 'package:glow/pages/FlyerDetail.dart';
import 'package:glow/storage/FavouriteStore.dart';
import 'package:glow/utils/External.dart';
import 'package:glow/utils/Utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FlyerListPage extends StatefulWidget {
  FlyerListPage({Key? key}) : super(key: key);

  @override
  FlyerListPageState createState() => FlyerListPageState();
}

class FlyerListPageState extends State<FlyerListPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
  );

  List<String> favourites = List.empty(growable : true);

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _initFavouriteList();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future<void> _initFavouriteList() async {
    final favouritesTemp = await FavouriteStore.getFavourites();
    developer.log('FlyerListPage', name: favouritesTemp.toString());
    setState(() {
      favourites.clear();
      favourites.addAll(favouritesTemp);
    });
  }

  void reload() {
    _initFavouriteList();
  }

  @override
  Widget build(BuildContext context) {
    developer.log('FlyerListPage', name: 'build');
    Utils.initialize(context);

    return Scaffold(appBar: createAppBar(), drawer: createDrawer(), body: createBody());
  }

  AppBar createAppBar() {
    return AppBar(
      backgroundColor: CommonColors.primary,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      title: Text("GLOW Deutschland"),
      actions: createAppBarActions(),
    );
  }

  List<Widget> createAppBarActions() {
    List<Widget> actions = List.empty(growable: true);

    if (favourites.isNotEmpty) {
      actions.add(IconButton(
        icon: Icon(CommonIconsDyn.more),
        onPressed: onMorePressed,
      ));
    }

    return actions;
  }

  void onMorePressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Wrap(children: <Widget>[
              Column(
                children: <Widget>[
                  ListTile(
                      onTap: () {
                        FavouriteStore.clearFavourites().then((value) => _initFavouriteList());
                        Navigator.pop(context);
                      },
                      leading: createDrawerIcon(CommonIconsDyn.favouriteDeactivated),
                      title: Text("Favoriten zurücksetzen")),
                ],
              )
            ]));
  }

  Widget createBody() {
    return FutureBuilder<List<String>>(
        future: FavouriteStore.getFavourites(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return createGrid(snapshot.data!);
          } else {
            return Container();
          }
        });
  }

  Widget createGrid(List<String> favourites) {
    var displayWidth = Utils.getDisplaySizeWidth(context);
    var spacing = Utils.SPACE1_D;
    var flyerWidth = Utils.SPACE4_D * 2;
    var horizontalCount = (displayWidth - spacing) ~/ (flyerWidth + spacing);

    flyerWidth = (displayWidth - (spacing + spacing * horizontalCount)) / horizontalCount;

    return GridView.count(
        padding: EdgeInsets.symmetric(vertical: spacing),
        crossAxisCount: horizontalCount.toInt(),
        mainAxisSpacing: Utils.SPACE2_D,
        children: createFlyerList(favourites));
  }

  List<Widget> createFlyerList(List<String> favourites) {
    List<Flyer> flyersFavourite = List.empty(growable: true);
    List<Flyer> flyersNonFavourite = List.empty(growable: true);

    Resources().flyers.forEach((flyer) {
      var isFavourite = favourites.contains(flyer.id);
      if (isFavourite) {
        flyersFavourite.add(flyer);
      } else {
        flyersNonFavourite.add(flyer);
      }
    });

    flyersFavourite.sort((a, b) => a.title.compareTo(b.title));
    flyersNonFavourite.sort((a, b) => a.title.compareTo(b.title));

    List<Flyer> sorted = List.empty(growable: true);
    sorted.addAll(flyersFavourite);
    sorted.addAll(flyersNonFavourite);

    return List.generate(sorted.length, (flyerIndex) {
      Flyer flyer = sorted[flyerIndex];
      return createFlyer(flyer, favourites.contains(flyer.id));
    });
  }

  Widget createFlyer(Flyer flyer, bool isFavourite) {
    return FutureBuilder<bool>(
        future: FavouriteStore.isFavourite(flyer.id),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data != null && snapshot.data!) {
            var list = List<Widget>.empty(growable: true);
            list.add(Image.asset(flyer.cover));
            list.add(createFlyerFavourite());
            list.add(createFlyerClickArea(flyer));

            return Center(
              child: Card(
                  elevation: 12,
                  child: Stack(
                    children: list,
                  )),
            );
          } else {
            var list = List<Widget>.empty(growable: true);
            list.add(Image.asset(flyer.cover));
            list.add(createFlyerClickArea(flyer));

            return Center(
              child: Card(
                  elevation: 12,
                  child: Stack(
                    children: list,
                  )),
            );
          }
        });
  }

  Widget createFlyerFavourite() {
    return Positioned.fill(
        child: Align(
            alignment: Alignment.topRight,
            child: Container(
                padding: EdgeInsets.all(4),
                color: Colors.white.withAlpha(150),
                child: Icon(CommonIconsDyn.favouriteActivated, color: CommonColors.primary))));
  }

  Widget createFlyerClickArea(Flyer flyer) {
    return Positioned.fill(
        child: new Material(
            color: Colors.transparent,
            child: new InkWell(
              splashColor: CommonColors.primary.withAlpha(150),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlyerDetailPage(flyer.id)),
                ).then((value) => reload());
              },
            )));
  }

  Drawer createDrawer() {
    return Drawer(child: createDrawerMenu());
  }

  Widget createDrawerMenu() {
    return ListView(padding: EdgeInsets.zero, children: <Widget>[
      DrawerHeader(
        margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          child: Image.asset("${CommonPaths.DA}glow_logo_vertical_white.png"),
          decoration: const BoxDecoration(color: CommonColors.primary)),
      Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.only(right: 16, bottom: 16),
          decoration: const BoxDecoration(color: CommonColors.primary ),
          child: Align(
              alignment: Alignment.centerRight,
              child: Text("Version " + _packageInfo.version, style: TextStyle(fontSize: 11, color: Colors.white)))),
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
          title: Text("Kontakt"))
    ]);
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
