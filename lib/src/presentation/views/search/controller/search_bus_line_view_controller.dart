import 'package:tarbus2021/src/model/database/database_helper.dart';
import 'package:tarbus2021/src/model/entity/bus_stop.dart';
import 'package:tarbus2021/src/utils/string_utils.dart';

class SearchBusStopViewController {
  bool searchStatus;

  SearchBusStopViewController() {
    searchStatus = false;
  }

  void startSearch(String pattern) {
    if (pattern.trim().isNotEmpty) {
      searchStatus = true;
    } else {
      searchStatus = false;
    }
  }

  Future<List<BusStop>> getSearchedBusStops(String text) {
    var pattern = text;
    pattern = pattern.trim();
    pattern = pattern.toLowerCase();
    pattern = StringUtils.removeLowercasePolishLetters(pattern);
    var patterns = pattern.split(' ');
    return DatabaseHelper.instance.getSearchedBusStops(patterns);
  }
}
