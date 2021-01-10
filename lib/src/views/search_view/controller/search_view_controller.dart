import 'package:flutter/cupertino.dart';
import 'package:tarbus2021/src/database/database_helper.dart';
import 'package:tarbus2021/src/model/bus_stop.dart';
import 'package:tarbus2021/src/model/unwanted_letter_holder.dart';

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
    List<UnwantedLetterHolder> unwantedLetters = [
      UnwantedLetterHolder('ą', 'a'),
      UnwantedLetterHolder('ć', 'c'),
      UnwantedLetterHolder('ę', 'e'),
      UnwantedLetterHolder('ł', 'l'),
      UnwantedLetterHolder('ń', 'n'),
      UnwantedLetterHolder('ó', 'o'),
      UnwantedLetterHolder('ś', 's'),
      UnwantedLetterHolder('ź', 'z'),
      UnwantedLetterHolder('ż', 'z'),
    ];

    pattern = pattern.trim();
    pattern = pattern.toLowerCase();
    for (UnwantedLetterHolder unwantedLetter in unwantedLetters) {
      pattern = pattern.replaceAll(unwantedLetter.oldChar, unwantedLetter.newChar);
    }
    List<String> patterns = pattern.split(' ');
    return DatabaseHelper.instance.getSearchedBusStops(patterns);
  }
}
