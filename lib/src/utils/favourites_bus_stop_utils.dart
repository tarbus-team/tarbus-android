import 'package:shared_preferences/shared_preferences.dart';

class FavouritesBusStopUtils {
  static Future<bool> checkIfExist(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String existedFavourites = (prefs.getString('FAVOURITE_BUS_STOPS') ?? "");
    print('$existedFavourites - $id');
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
    await prefs.setString('FAVOURITE_BUS_STOPS', result.toString());
    return true;
  }

  static Future<bool> removeFavouriteBusStop(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String existedFavourites = (prefs.getString('FAVOURITE_BUS_STOPS') ?? "");
    if (existedFavourites.isNotEmpty) {
      StringBuffer result = StringBuffer();
      var favouritesArray = existedFavourites.split(',');
      var istFirstIteration = true;

      for (int i = 0; i < favouritesArray.length; i++) {
        if (i % 2 == 0) {
          if (id != favouritesArray[i]) {
            if (!istFirstIteration) {
              result.write(',');
            }
            result.write(favouritesArray[i]);
            result.write(',${favouritesArray[i + 1]}');
            istFirstIteration = false;
          }
        }
      }
      await prefs.setString('FAVOURITE_BUS_STOPS', result.toString());
    }
    return true;
  }

  static Future<bool> editName(String id, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String existedFavourites = (prefs.getString('FAVOURITE_BUS_STOPS') ?? "");
    if (existedFavourites.isNotEmpty) {
      StringBuffer result = StringBuffer();
      var favouritesArray = existedFavourites.split(',');
      var istFirstIteration = true;

      for (int i = 0; i < favouritesArray.length; i++) {
        if (i % 2 == 0) {
          if (id == favouritesArray[i]) {
            favouritesArray[i + 1] = name;
          }
          if (!istFirstIteration) {
            result.write(',');
          }
          result.write(favouritesArray[i]);
          result.write(',${favouritesArray[i + 1]}');
          istFirstIteration = false;
        }
      }
      await prefs.setString('FAVOURITE_BUS_STOPS', result.toString());
    }
    return true;
  }
}
