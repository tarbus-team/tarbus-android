import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus2021/app/app_colors.dart';
import 'package:tarbus2021/config/config.dart';
import 'package:tarbus2021/model/entity/departure.dart';
import 'package:tarbus2021/presentation/views/track_details/track_details_view.dart';

class MiniScheduleItem extends StatelessWidget {
  final Departure departure;
  final int busStopId;

  const MiniScheduleItem({Key key, this.departure, this.busStopId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var busLineName = departure.busLine.name;
    if (busLineName.length == 3) {
      busLineName = '$busLineName  ';
    }
    return Container(
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<String>(
              builder: (context) => TrackDetailsView(track: departure.track, busStopId: busStopId)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildBusLineBox(context, busLineName), _buildDepartureTimeBox(context)],
        ),
      ),
    );
  }

  Widget _buildBusLineBox(BuildContext context, String busLineName) {
    return Container(
      height: 25,
      color: AppConfig.of(context).brandColors.primary,
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/icon_bus.svg',
              color: Colors.white,
              height: 11,
              width: 11,
            ),
            Container(
              width: 3,
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

  Widget _buildDepartureTimeBox(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              departure.timeInString,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.instance(context).mainFontColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
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
