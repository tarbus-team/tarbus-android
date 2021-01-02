import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/database/database_helper.dart';
import 'package:tarbus2021/src/model/bus_stop.dart';
import 'package:tarbus2021/src/views/bus_stop_list_view/bus_stop_list_item.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<BusStop> busStopsList = List<BusStop>();
  List<BusStop> searchedBusStopsList = List<BusStop>();

  bool status = false;

  FocusNode myFocusNode;

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getBusStopList();
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();
  }

  void _getBusStopList() async {
    busStopsList = await DatabaseHelper.instance.getAllBusStops();
    searchedBusStopsList = List<BusStop>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new TextField(
          focusNode: myFocusNode,
          onChanged: (text) {
            setState(() {
              if (text.trim().length != 0) {
                status = true;
              }
              _doSearchQuery(text);
            });
          },
          style: new TextStyle(
            color: Colors.white,
          ),
          decoration: new InputDecoration(
              suffixIcon: new Icon(Icons.search, color: Colors.white), hintText: "Search...", hintStyle: new TextStyle(color: Colors.white)),
        ),
      ),
      body: status
          ? ListView.builder(
              itemCount: searchedBusStopsList.length,
              itemBuilder: (context, index) {
                return BusStopListItem(busStop: searchedBusStopsList[index]);
              },
            )
          : Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Zacznij wpisywać tekst aby wyszukać przystanek",
                maxLines: 2,
              )),
    );
  }

  void _doSearchQuery(String text) async {
    searchedBusStopsList.clear();
    for (BusStop busStop in busStopsList) {
      String result = busStop.name.toLowerCase().trim();
      text = text.toLowerCase().trim();
      if (result.contains(text)) {
        searchedBusStopsList.add(busStop);
        print(result);
      }
    }
  }
}
