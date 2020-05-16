import 'package:glow/flyer.dart';

final Resources resources = new Resources();

class Resources {
  static final Resources _singleton = Resources._internal();

  factory Resources() {
    return _singleton;
  }

  Resources._internal();

  var flyers = new List<Flyer>();

  void init() {
    flyerIndex.forEach((index) {
      var flyer = Flyer.empty();
      flyer.content = "assets/flyer/$index/020content.html";
      flyer.cover = "assets/flyer/$index/010cover.png";
      flyers.add(flyer);
    });
  }

  var flyerIndex = [
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
