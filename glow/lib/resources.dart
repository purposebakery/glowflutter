
import 'package:glow/flyer.dart';

final Resources resources = new Resources._private();
const AMOUNT = 33;

class Resources {
  var flyers = new List<Flyer>(AMOUNT);
  Resources._private() {
    for (var i = 0; i < AMOUNT; ++i) {
      var flyerId = "p" + ((i+1).toString().padLeft(2, "0"));
      flyers[i] = new Flyer("Test", "assets/flyer/${flyerId}_cover.png", "assets/flyer/${flyerId}_content.html");
    }
  }

}
