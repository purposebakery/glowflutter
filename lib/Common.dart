import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommonColors {
  static const Color primary = Color(0xFF143945);
}

class CommonStrings {
  static const String homepage_url = "https://glowdeutschland.de";
  static const String shop_url = "https://www.adventistbookcenter.de/abc/glow";
  static const String email_uri = "mailto:deutschland@glowonline.org";
  static const String phone_uri = "tel:+4952514179517";
}

class CommonPaths {
  static const String DA = "assets/drawables/";
  static const String FLYER = "assets/flyer/";
}

class CommonIconsDyn {
  static IconData share = Platform.isIOS ? CupertinoIcons.share : Icons.share;
  static IconData shop = Platform.isIOS ? CupertinoIcons.shopping_cart : Icons.shopping_cart;
  static IconData mail = Platform.isIOS ? CupertinoIcons.mail : Icons.mail;
  static IconData phone = Platform.isIOS ? CupertinoIcons.phone : Icons.phone;
  static IconData home = Platform.isIOS ? CupertinoIcons.home : Icons.home;
}

class CommonSpace {
  static const double SPACE_1 = 16.0;
}
