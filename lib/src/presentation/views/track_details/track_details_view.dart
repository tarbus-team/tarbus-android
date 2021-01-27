import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/model/database/database_helper.dart';
import 'package:tarbus2021/src/model/entity/departure.dart';
import 'package:tarbus2021/src/model/entity/track.dart';
import 'package:tarbus2021/src/presentation/views/track_details/track_details_item.dart';

class TrackDetailsView extends StatelessWidget {
  final Track track;
  final int busStopId;

  const TrackDetailsView({Key key, this.track, this.busStopId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("BUSSTOP DUPA 34545345345: $busStopId");
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
                track.destination.directionBoardName,
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
                  print("busStopId: $busStopId, departureBusStopId: ${departure.busStop.id}");
                  if (busStopId == departure.busStop.id) {
                    currentIndex = index;
                  }
                  if (index == (snapshot.data.length - 1)) {
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
