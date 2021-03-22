import 'package:tarbus2021/model/database/database_helper.dart';
import 'package:tarbus2021/model/entity/bus_line.dart';

class SearchBusLineViewController {
  bool searchStatus;

  SearchBusLineViewController() {
    searchStatus = false;
  }

  void startSearch(String pattern) {
    if (pattern.trim().isNotEmpty) {
      searchStatus = true;
    } else {
      searchStatus = false;
    }
  }

  Future<List<BusLine>> getSearchedBusLineList(String text) {
    var pattern = text;
    pattern = pattern.trim();
    pattern = pattern.toUpperCase();
    var patterns = pattern.split(' ');
    return DatabaseHelper.instance.getSearchedBusLines(patterns);
  }
}
