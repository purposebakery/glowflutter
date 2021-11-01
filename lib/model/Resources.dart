import 'dart:collection';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:glow/Common.dart';
import 'package:glow/model/Flyer.dart';
import 'package:glow/utils/Utils.dart';

import 'FlyerMeta.dart';

final Resources resources = new Resources();

class Resources {
  static final Resources _singleton = Resources._internal();

  factory Resources() {
    return _singleton;
  }

  Resources._internal();

  var flyers = new List<Flyer>.empty(growable: true);
  var flyerMap = new HashMap<String, Flyer>();

  void init() {
    developer.log('Resources', name: 'init');

    flyers.clear();
    flyerMap.clear();

    var flyerIds = [
      "010", // COVID19
      "020",
      "030",
      "040",
      "050",
      "060",
      "070",
      "080",
      "090",
      "100",
      "105",
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
      //"270", // Twilight
      "280",
      "290",
      "300",
      "310",
      "320",
      "330",
      "340",
      "350", // Medien und das Gehirn
      "360", // TODO Gibt es Geister wirklich
      "370" // TODO Aufruf der liebe
    ];

    if (Platform.isIOS) {
      flyerIds.remove("010"); // COVID19
    }

    flyerIds.forEach((id) {
      var flyer = Flyer.empty();
      flyer.id = id;
      flyer.content = "${CommonPaths.FLYER}${id}content.html";
      flyer.cover = "${CommonPaths.FLYER}${id}cover.png";

      Utils.getFileData("${CommonPaths.FLYER}${id}meta.json").then((value) => parseJson(value, flyer));

      flyers.add(flyer);
      flyerMap[id] = flyer;
    });

    flyers.sort((a, b) => a.title.compareTo(b.title));

    flyers.forEach((flyer) {
      flyerMap[flyer.id] = flyer;
    });
  }

  parseJson(String jsonData, Flyer flyer) {
    var parsedJson = json.decode(jsonData);
    var meta = FlyerMeta(parsedJson);
    flyer.title = meta.title;
    flyer.titleShort = meta.titleShort;
    flyer.url = meta.url;
  }
}
