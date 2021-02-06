import 'package:shared_preferences/shared_preferences.dart';

class FavouritesBusLineUtils {
  static Future<bool> checkIfExist(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String existedFavourites = (prefs.getString('FAVOURITE_BUS_LINES') ?? "");
    if (existedFavourites.isNotEmpty) {
      var favouritesArray = existedFavourites.split(',');
      for (String busLine in favouritesArray) {
        if (busLine == id) {
          return true;
        }
      }
    }
    return false;
  }

  static Future<bool> addFavouriteBusLine(String id) async {
    StringBuffer result = StringBuffer();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String existedFavourites = (prefs.getString('FAVOURITE_BUS_LINES') ?? "");
    result.write(existedFavourites);
    if (existedFavourites.isNotEmpty) {
      result.write(',');
    }
    result.write(id);
    await prefs.setString('FAVOURITE_BUS_LINES', result.toString());
    return true;
  }

  static Future<bool> removeFavouriteBusLine(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String existedFavourites = (prefs.getString('FAVOURITE_BUS_LINES') ?? "");
    if (existedFavourites.isNotEmpty) {
      StringBuffer result = StringBuffer();
      var favouritesArray = existedFavourites.split(',');
      bool isFirstIteration = true;
      for (String busLine in favouritesArray) {
        if (busLine != id) {
          if (!isFirstIteration) {
            result.write(',');
          }
          result.write(busLine);
          isFirstIteration = false;
        }
      }
      await prefs.setString('FAVOURITE_BUS_LINES', result.toString());
    }
    return true;
  }
}
