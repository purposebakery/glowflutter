import 'package:flutter/material.dart';
import 'package:glow/Common.dart';

class DialogUtils {
  static Future<void> showAlertDialog(BuildContext context, DialogParameters parameters) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: parameters.dismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(parameters.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: createContentText(context, parameters),
            ),
          ),
          actions: generateActions(context, parameters),
        );
      },
    );
  }


  static List<Widget> createContentText(BuildContext context, DialogParameters parameters) {
    var content = List<Widget>.empty(growable: true);
    if (parameters.message != null) {
      content.add(Text(parameters.message!));
    }
    return content;
  }


  static List<Widget> generateActions(BuildContext context, DialogParameters parameters) {
    var actions = List<Widget>.empty(growable: true);
    if (parameters.negativeButton != null) {
      actions.add(TextButton(
        child: Text(parameters.negativeButton!),
        onPressed: () {
          Navigator.of(context).pop();
          if (parameters.negativeCallback != null) {
            parameters.negativeCallback!();
          }
        },
      ));
    }
    if (parameters.positiveButton != null) {
      actions.add(TextButton(
        child: Text(
          parameters.positiveButton!,
          style: TextStyle(color: Colors.white),
        ),
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(CommonColors.primary)),
        onPressed: () {
          Navigator.of(context).pop();
          if (parameters.positiveCallback != null) {
            parameters.positiveCallback!();
          }
        },
      ));
    }

    return actions;
  }
}

class DialogParameters {
  bool dismissible = true;
  String title = "";
  String? message;
  String? positiveButton;
  Function? positiveCallback;
  String? negativeButton;
  Function? negativeCallback;
}
