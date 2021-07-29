import 'package:glow/utils/Utils.dart';

class Flyer {
  String id = "";
  String title = "";
  String titleShort = "";
  String cover = "";
  String content = "";
  String url = "";

  Flyer.empty();

  Flyer(this.id, this.title, this.titleShort, this.cover, this.content, this.url);

  Future<String> loadContent() {
    return Utils.getFileData(content);
  }
}
