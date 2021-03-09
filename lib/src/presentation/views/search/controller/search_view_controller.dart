import 'package:flutter/cupertino.dart';
import 'package:tarbus2021/src/model/database/database_helper.dart';
import 'package:tarbus2021/src/model/entity/bus_stop.dart';
import 'package:tarbus2021/src/utils/string_utils.dart';

class SearchViewController {
  FocusNode focusNode;
  bool searchStatus;
  String searchValue;

  SearchViewController() {
    focusNode = FocusNode();
    searchStatus = false;
    searchValue = '';
  }

  void searchBusStop(String pattern) {
    if (pattern.trim().isNotEmpty) {
      searchStatus = true;
    } else {
      searchStatus = false;
    }
    searchValue = pattern;
  }

  Future<List<BusStop>> getSearchedBusStops(String text) {
    String pattern = text;

    pattern = pattern.trim();
    pattern = pattern.toLowerCase();
    pattern = StringUtils.removeLowercasePolishLetters(pattern);
    List<String> patterns = pattern.split(' ');
    return DatabaseHelper.instance.getSearchedBusStops(patterns);
  }
}
