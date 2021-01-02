import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/database/database_helper.dart';
import 'package:tarbus2021/src/model/bus_stop.dart';
import 'package:tarbus2021/src/views/search_view/search_view.dart';

import 'bus_stop_list_item.dart';

class BusStopListView extends StatelessWidget {
  const BusStopListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gmina Tarnów - Rozkład Jazdy")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchView()));
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "T10 - Wszytkie przystanki: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          Expanded(
            child: FutureBuilder<List<BusStop>>(
              //Fetching all the persons from the list using the istance of the DatabaseHelper class
              future: DatabaseHelper.instance.getAllBusStops(),
              builder: (BuildContext context, AsyncSnapshot<List<BusStop>> snapshot) {
                //Checking if we got data or not from the DB
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      BusStop busStop = snapshot.data[index];
                      return BusStopListItem(busStop: busStop);
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
