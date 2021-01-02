import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/model/bus_stop.dart';
import 'package:tarbus2021/src/views/schedule_view/schedule_view.dart';

class BusStopListItem extends StatelessWidget {
  final BusStop busStop;

  const BusStopListItem({Key key, this.busStop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.symmetric(vertical: 5.0),
      child: RaisedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleView(busStop: busStop)));
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                busStop.name,
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
                  Expanded(child: Text(busStop.parsedDestinations, maxLines: 2)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
