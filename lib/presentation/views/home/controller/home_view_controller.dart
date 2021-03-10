import 'package:tarbus2021/app/app_consts.dart';
import 'package:tarbus2021/model/database/database_helper.dart';
import 'package:tarbus2021/model/entity/bus_line.dart';
import 'package:tarbus2021/model/entity/favourite_bus_stop.dart';
import 'package:tarbus2021/utils/shared_preferences_utils.dart';

class HomeViewController {
  void addDialogToList(String id) {
    DatabaseHelper.instance.addDialogToList(id);
  }

  Future<List<FavouriteBusStop>> getFavouritesBusStops() async {
    var favourites = await SharedPreferencesUtils.getSharedListString(AppConsts.SharedPreferencesFavStop);
    var favList = <FavouriteBusStop>[];

    for (var favourite in favourites) {
      var favItem = favourite.split(', ');
      var _busStop = await DatabaseHelper.instance.getFavouritesBusStop(favItem[0]);
      favList.add(FavouriteBusStop(name: favItem[1], busStop: _busStop));
    }

    return favList;
  }

  Future<List<BusLine>> getFavouritesBusLines() async {
    var favourites = await SharedPreferencesUtils.getSharedListString(AppConsts.SharedPreferencesFavLine);
    return await DatabaseHelper.instance.getFavouritesBusLines(favourites.join(','));
  }
}
