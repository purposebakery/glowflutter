import 'package:flutter/services.dart';

class LocalLoader {
  Future<String> loadLocal(String assetFile) async {
    return await rootBundle.loadString(assetFile);
  }
}