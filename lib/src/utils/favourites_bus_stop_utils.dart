import 'package:shared_preferences/shared_preferences.dart';

class FavouritesBusStopUtils {
  static Future<bool> checkIfExist(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String existedFavourites = (prefs.getString('FAVOURITE_BUS_STOPS') ?? "");
    if (existedFavourites.isNotEmpty) {
      var favouritesArray = existedFavourites.split(',');
      int counter = 0;
      for (String busLine in favouritesArray) {
        if (counter % 2 == 0) {
          if (busLine == id) {
            return true;
          }
        }
        counter++;
      }
    }
    return false;
  }

  static Future<bool> addFavouriteBusStop(String id, String name) async {
    StringBuffer result = StringBuffer();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String existedFavourites = (prefs.getString('FAVOURITE_BUS_STOPS') ?? "");
    result.write(existedFavourites);
    if (existedFavourites.isNotEmpty) {
      result.write(',');
    }
    result.write(id);
    result.write(',$name');
    print(result.toString());
    await prefs.setString('FAVOURITE_BUS_STOPS', result.toString());
    return true;
  }

  static Future<bool> removeFavouriteBusStop(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String existedFavourites = (prefs.getString('FAVOURITE_BUS_STOPS') ?? "");
    if (existedFavourites.isNotEmpty) {
      StringBuffer result = StringBuffer();
      var favouritesArray = existedFavourites.split(',');
      for (int i = 0; i < favouritesArray.length; i++) {
        if (i % 2 == 0) {
          if (id != favouritesArray[i]) {
            if (i > 0) {
              result.write(',');
            }
            result.write(favouritesArray[i]);
            result.write(',${favouritesArray[i]}');
          }
        }
      }
      print(result.toString());
      await prefs.setString('FAVOURITE_BUS_STOPS', result.toString());
    } else {
      print("removeFavouriteBusLine - Error 2");
    }
    return true;
  }
}
