import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:glow/utils/DialogUtils.dart';
import 'package:url_launcher/url_launcher.dart';

class External {
  static launchURL(BuildContext context, String? url) async {
    if (url == null) {
      return;
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      DialogParameters parameters = DialogParameters();
      parameters.title = "Oh nein...";
      parameters.message = "Ich konnte \"${removePrefix(url)}\" nicht öffnen. Wahrscheinlich fehlt die App dafür.";
      parameters.positiveButton = "Ok";
      DialogUtils.showAlertDialog(context, parameters);
    }
  }

  static shareText(BuildContext context, String text) async {
    FlutterShareMe().shareToSystem(msg: text).then( (dynamic value) => checkShareResult(context, text, value));
  }

  static checkShareResult(BuildContext context, String text, dynamic value) {
    if (value == "false") {
      DialogParameters parameters = DialogParameters();
      parameters.title = "Oh nein...";
      parameters.message = "Ich konnte \"${removePrefix(text)}\" nicht teilen. Wahrscheinlich fehlt die App dafür.";
      parameters.positiveButton = "Ok";
      DialogUtils.showAlertDialog(context, parameters);
    }
  }
  
  static String removePrefix(String text) {
    text = text.replaceAll("mailto:", "");
    text = text.replaceAll("tel:", "");
    return text;
  }
}
