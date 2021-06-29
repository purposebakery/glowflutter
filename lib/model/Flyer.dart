import 'package:glow/utils/Utils.dart';

class Flyer {
  String id = "";
  String title = "";
  String cover = "";
  String content = "";
  String url = "";

  Flyer.empty();

  Flyer(this.id, this.title, this.cover, this.content, this.url);

  Future<String> loadContent() {
    return getFileData(content);
  }
}
