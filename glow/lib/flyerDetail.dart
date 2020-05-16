import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlyerDetailPage extends StatefulWidget {
  FlyerDetailPage({this.flyerId}) : super(key: new ValueKey(flyerId));
  final String flyerId;

  @override
  FlyerDetailPageState createState() => FlyerDetailPageState();
}

class FlyerDetailPageState extends State<FlyerDetailPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar(),
        //body: createBody()
    );
  }


  AppBar createAppBar() {
    return AppBar(
      title: Text("BLAAAA"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.share),
          tooltip: 'Share',
          onPressed: () {
            Fluttertoast.showToast(msg: "${widget.flyerId}");
          },
        )
      ],
    );
  }
}