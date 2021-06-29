import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class External {
  static launchURL(String? url) async {
    if (url == null) {
      return;
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(
          msg: "Konnte $url nicht öffnen. Fehlt die App dafür?",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          timeInSecForIosWeb: 2);
    }
  }

  static shareText(String text) async {
    FlutterShareMe().shareToSystem(msg: text).then(checkShareResult);
  }

  static checkShareResult(dynamic value) {
    if (value == "false") {
      Fluttertoast.showToast(
          msg: "Konnte text nicht teilen. Fehlt die App dafür?",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          timeInSecForIosWeb: 2);
    }
  }
}
