import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarbus2021/src/model/database/database_helper.dart';
import 'package:tarbus2021/src/model/entity/bus_line.dart';
import 'package:tarbus2021/src/model/entity/favourite_bus_stop.dart';

class HomeViewController {
  void addDialogToList(var id) {
    DatabaseHelper.instance.addDialogToList(id);
  }

  Future<List<FavouriteBusStop>> getFavouritesBusStops() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String favourites = (prefs.getString('FAVOURITE_BUS_STOPS') ?? null);

    if (favourites == null) {
      return <FavouriteBusStop>[];
    }
    var list = <FavouriteBusStop>[];
    var favouritesList = favourites.split(',');
    for (int i = 0; i < favouritesList.length; i++) {
      if (i % 2 == 0) {
        print(i);
        var _busStop = await DatabaseHelper.instance.getFavouritesBusStop(favouritesList[i]);
        list.add(FavouriteBusStop(name: favouritesList[i + 1], busStop: _busStop));
      }
    }
    return list;
  }

  Future<List<BusLine>> getFavouritesBusLines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String favourites = (prefs.getString('FAVOURITE_BUS_LINES') ?? null);
    if (favourites == null) {
      return <BusLine>[];
    }
    return await DatabaseHelper.instance.getFavouritesBusLines(favourites);
  }
}
