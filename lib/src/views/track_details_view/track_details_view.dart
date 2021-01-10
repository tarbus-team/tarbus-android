import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/database/database_helper.dart';
import 'package:tarbus2021/src/model/departure.dart';
import 'package:tarbus2021/src/model/track.dart';
import 'package:tarbus2021/src/views/track_details_view/track_details_item.dart';

class TrackDetailsView extends StatelessWidget {
  final Track track;
  final int busStopId;

  const TrackDetailsView({Key key, this.track, this.busStopId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentIndex = -2;
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          "assets/logo_tarbus_header.svg",
          color: Colors.white,
          height: 35,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        bottom: PreferredSize(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                track.destination.name,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            preferredSize: Size.fromHeight(40)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: FutureBuilder<List<Departure>>(
          future: DatabaseHelper.instance.getDeparturesByTrackId(track.id),
          builder: (BuildContext context, AsyncSnapshot<List<Departure>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var departure = snapshot.data[index];
                  var parsedIndex = index;
                  if (busStopId == departure.busStop.number) {
                    currentIndex = index;
                  }
                  if (index == snapshot.data.length - 1) {
                    parsedIndex = -1;
                  }

                  return TrackDetailsItemView(departure: departure, index: parsedIndex, currentIndex: currentIndex);
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
