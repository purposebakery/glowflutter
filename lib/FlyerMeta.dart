class FlyerMeta {
  String title = "";
  String url = "";
  FlyerMeta(Map<String, dynamic> data) {
    title = data['title'];
    url = data['url'];
  }
}