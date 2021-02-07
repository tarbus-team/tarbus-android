import 'package:tarbus2021/src/model/database/database_helper.dart';
import 'package:tarbus2021/src/model/entity/bus_line.dart';

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
    String pattern = text;
    pattern = pattern.trim();
    pattern = pattern.toUpperCase();
    List<String> patterns = pattern.split(' ');
    return DatabaseHelper.instance.getSearchedBusLines(patterns);
  }
}
