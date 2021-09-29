import 'package:shared_preferences/shared_preferences.dart';

class FavouriteStore {
  static const String KEY_FAVOURITE = "KEY_FAVOURITE";

  static Future<List<String>> getFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      var list = prefs.getStringList(KEY_FAVOURITE);
      if (list == null) {
        return List.empty();
      } else {
        return list;
      }
    } on Exception catch (_) {
      return List.empty();
    }
  }

  static Future<bool> isFavourite(String favourite) async {
    var favourites = await getFavourites();

    return favourites.contains(favourite);
  }

  static Future<void> addFavourite(String favourite) async {
    var list = await getFavourites();
    var newList = List<String>.empty(growable: true);
    newList.addAll(list);
    newList.add(favourite);
    storeFavourites(newList);
  }

  static Future<void> clearFavourites() async {
    return storeFavourites(List<String>.empty());
  }

  static Future<void> removeFavourite(String favourite) async {
    var list = await getFavourites();
    var newList = List<String>.empty(growable: true);
    newList.addAll(list);
    newList.remove(favourite);
    storeFavourites(newList);
  }

  static Future<void> storeFavourites(List<String> favourites) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(KEY_FAVOURITE, favourites);
  }
}