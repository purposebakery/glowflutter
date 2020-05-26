import 'dart:collection';
import 'dart:convert';

import 'package:glow/flyer.dart';
import 'package:glow/common.dart';
import 'package:glow/utils.dart';

import 'flyerMeta.dart';

final Resources resources = new Resources();

class Resources {
  static final Resources _singleton = Resources._internal();

  factory Resources() {
    return _singleton;
  }

  Resources._internal();

  var flyers = new List<Flyer>();
  var flyerMap = new HashMap<String, Flyer>();

  void init() {
    flyers.clear();
    flyerMap.clear();

    flyerIds.forEach((id) {
      var flyer = Flyer.empty();
      flyer.id = id;
      flyer.content = "$FLYER${id}content.html";
      flyer.cover = "$FLYER${id}cover.png";

      getFileData("$FLYER${id}meta.json").then((value) => parseJson(value, flyer));

      flyers.add(flyer);
      flyerMap[id] = flyer;
    });
  }

  parseJson(String jsonData, Flyer flyer) {
    var parsedJson = json.decode(jsonData);
    var meta = FlyerMeta(parsedJson);
    flyer.title = meta.title;
    flyer.url = meta.url;
  }

  var flyerIds = [
    "010",
    "020",
    "030",
    "040",
    "050",
    "060",
    "070",
    "080",
    "090",
    "100",
    "110",
    "120",
    "130",
    "140",
    "150",
    "160",
    "170",
    "180",
    "190",
    "200",
    "210",
    "220",
    "230",
    "240",
    "250",
    "260",
    "270",
    "280",
    "290",
    "300",
    "310",
    "320",
    "330",
    "340"
  ];
}
