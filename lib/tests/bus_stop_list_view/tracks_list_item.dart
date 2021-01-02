import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/model/track.dart';
import 'package:tarbus2021/src/views/track_details_view/track_details_view.dart';

class TracksListItem extends StatelessWidget {
  final Track track;

  const TracksListItem({Key key, this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.symmetric(vertical: 5.0),
      child: RaisedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TrackDetailsView(track: track)));
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                track.id.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                height: 15,
              ),
              Row(
                children: [
                  Icon(Icons.arrow_forward),
                  Expanded(child: Text(track.types, maxLines: 2)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
