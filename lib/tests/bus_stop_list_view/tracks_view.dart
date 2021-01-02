import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/database/database_helper.dart';
import 'package:tarbus2021/src/model/track.dart';
import 'package:tarbus2021/src/views/search_view/search_view.dart';
import 'package:tarbus2021/tests/bus_stop_list_view/tracks_list_item.dart';

class TracksView extends StatelessWidget {
  const TracksView({Key key}) : super(key: key);

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
          Expanded(
            child: FutureBuilder<List<Track>>(
              //Fetching all the persons from the list using the istance of the DatabaseHelper class
              future: DatabaseHelper.instance.getAllTracks(),
              builder: (BuildContext context, AsyncSnapshot<List<Track>> snapshot) {
                //Checking if we got data or not from the DB
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Track track = snapshot.data[index];
                      return TracksListItem(track: track);
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
