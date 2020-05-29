import 'dart:ui';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Common {

  static const Color primary = Color(0xFF143945);

  static const String homepage_url = "https://glowdeutschland.de";
  static const String shop_url = "https://www.adventistbookcenter.de/abc/glow";
  static const String app_url = "https://glowdeutschland.de/apps/";

  static const String email_uri = "mailto:deutschland@glowonline.org";
  static const String phone_uri = "tel:+4952514179517";
}

const String DA = "assets/drawables/";
const String FLYER = "assets/flyer/";

class IconsDyn {
  static IconData share = Platform.isIOS ? CupertinoIcons.share : Icons.share;
  static IconData shop = Platform.isIOS ? CupertinoIcons.shopping_cart : Icons.shopping_cart;
  static IconData mail = Platform.isIOS ? CupertinoIcons.mail : Icons.mail;
  static IconData phone = Platform.isIOS ? CupertinoIcons.phone : Icons.phone;
  static IconData home = Platform.isIOS ? CupertinoIcons.home : Icons.home;

  //static const IconData shop = IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

const double SPACE_1 = 16.0;