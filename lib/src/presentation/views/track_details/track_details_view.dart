import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/model/database/database_helper.dart';
import 'package:tarbus2021/src/model/entity/departure.dart';
import 'package:tarbus2021/src/model/entity/track.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/appbar_title.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/horizontal_line.dart';
import 'package:tarbus2021/src/presentation/views/track_details/track_details_item.dart';

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
          children: [AppBarTitle(title: 'Trasa wybranego odjazdu')],
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
                child: Text('Kierunek:'),
              ),
              ListTile(
                title: Text(track.destination.directionBoardName, style: TextStyle(fontWeight: FontWeight.bold)),
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

                        return TrackDetailsItemView(departure: departure, index: parsedIndex, currentIndex: currentIndex);
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
