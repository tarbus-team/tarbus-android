import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/app/app_string.dart';
import 'package:tarbus2021/model/database/database_helper.dart';
import 'package:tarbus2021/model/entity/departure.dart';
import 'package:tarbus2021/model/entity/track.dart';
import 'package:tarbus2021/presentation/custom_widgets/appbar_title.dart';
import 'package:tarbus2021/presentation/custom_widgets/horizontal_line.dart';
import 'package:tarbus2021/presentation/views/bus_map/bus_map_view.dart';
import 'package:tarbus2021/presentation/views/track_details/track_details_item.dart';

class TrackDetailsView extends StatelessWidget {
  final Track track;
  final int busStopId;

  const TrackDetailsView({Key key, this.track, this.busStopId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentIndex = -2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [AppBarTitle(title: AppString.labelSelectedDepartureTrack)],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Text('${AppString.labelDestination}:'),
              ),
              ListTile(
                title: Text(track.destination.directionBoardName, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushNamed(BusMapView.route, arguments: track);
                  },
                  icon: Icon(Icons.map),
                  label: Text(
                    'Zobacz na mapie',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              HorizontalLine(),
              SizedBox(
                height: 20.0,
              ),
              FutureBuilder<List<Departure>>(
                future: DatabaseHelper.instance.getDeparturesByTrackId(track.id),
                builder: (BuildContext context, AsyncSnapshot<List<Departure>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var departure = snapshot.data[index];
                        var parsedIndex = index;
                        if (busStopId == departure.busStop.id) {
                          currentIndex = index;
                        }
                        if (index == (snapshot.data.length - 1)) {
                          parsedIndex = -1;
                        }

                        return TrackDetailsItemView(
                            departure: departure, index: parsedIndex, currentIndex: currentIndex);
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
