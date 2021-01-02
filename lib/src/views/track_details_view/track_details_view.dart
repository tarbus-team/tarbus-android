import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/database/database_helper.dart';
import 'package:tarbus2021/src/model/departure.dart';
import 'package:tarbus2021/src/model/track.dart';
import 'package:tarbus2021/src/views/track_details_view/track_details_item.dart';

class TrackDetailsView extends StatelessWidget {
  final Track track;

  const TrackDetailsView({Key key, this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(track.destination.name),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: FutureBuilder<List<Departure>>(
          //Fetching all the persons from the list using the istance of the DatabaseHelper class
          future: DatabaseHelper.instance.getDeparturesByTrackId(track.id),
          builder: (BuildContext context, AsyncSnapshot<List<Departure>> snapshot) {
            //Checking if we got data or not from the DB
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Departure departure = snapshot.data[index];
                  int parsedIndex = index;
                  if (index == snapshot.data.length - 1) {
                    parsedIndex = -1;
                  }
                  return TrackDetailsItemView(departure: departure, index: parsedIndex);
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
