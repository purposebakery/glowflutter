class FlyerMeta {
  String title = "";
  String titleShort = "";
  String url = "";

  FlyerMeta(Map<String, dynamic> data) {
    title = data['title'];
    titleShort = data['title_short'];
    url = data['url'];
  }
}
