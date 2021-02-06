import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/model/entity/departure.dart';
import 'package:tarbus2021/src/presentation/views/track_details/track_details_view.dart';

class ScheduleActualItem extends StatelessWidget {
  final Departure departure;
  final int busStopId;

  const ScheduleActualItem({Key key, this.departure, this.busStopId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var busLineName = departure.busLine.name;
    if (busLineName.length == 3) {
      busLineName = "$busLineName  ";
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) => TrackDetailsView(track: departure.track, busStopId: busStopId)));
        },
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        contentPadding: EdgeInsets.all(0),
        leading: _buildBusLineBox(busLineName),
        trailing: _buildDepartureTimeBox(),
        title: _buildDepartureNameBox(),
      ),
    );
  }

  Widget _buildBusLineBox(String busLineName) {
    return Container(
      width: 75.0,
      height: 40.0,
      decoration: new BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: new BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage("assets/icons/bus_b.png"),
              color: Colors.white,
              size: 16,
            ),
            Container(
              width: 4,
            ),
            Text(
              busLineName,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDepartureNameBox() {
    return Text(
      departure.track.destination.directionBoardName,
      style: TextStyle(fontSize: 14.0),
    );
  }

  Widget _buildDepartureTimeBox() {
    return Container(
      height: 40,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              departure.timeInString,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            if (departure.isTommorow)
              Text(
                'Jutro',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDevelop() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TrackId: ${departure.track.id}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: Colors.red,
          ),
        ),
        Text(
          'DepartueId: ${departure.id}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
