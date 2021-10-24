import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/departure.dart';
import 'package:tarbus_app/data/model/schedule/destination.dart';
import 'package:tarbus_app/data/model/schedule/track_route.dart';
import 'package:tarbus_app/views/pages/departures_page/all_departures_tab/time_grid_item.dart';

class TimetableListItem extends StatefulWidget {
  final TrackRoute route;
  final List<Departure> departures;
  final List<Destination> destinations;
  final String dayShortcut;

  const TimetableListItem({
    Key? key,
    required this.route,
    required this.departures,
    required this.destinations,
    required this.dayShortcut,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TimetableListItem();
}

class _TimetableListItem extends State<TimetableListItem> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ExpansionTile(
        onExpansionChanged: (status) {
          setState(() {
            _isExpanded = status;
          });
        },
        tilePadding: EdgeInsets.all(0),
        leading: _buildBusLineBox(widget.route.busLine.name),
        title: _buildDestinationNameBox(widget.route.destinationName),
        trailing: SizedBox(
          width: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                _buildDropdownIcon(),
                color: AppColors.of(context).fontColor,
              ),
            ],
          ),
        ),
        children: [
          _buildScheduleTable(),
        ],
      ),
    );
  }

  IconData _buildDropdownIcon() {
    if (_isExpanded) {
      return Icons.keyboard_arrow_up;
    }
    return Icons.keyboard_arrow_down;
  }

  Widget _buildDestinationNameBox(String destinationName) {
    return Text(
      destinationName,
      style: TextStyle(fontSize: 14, color: AppColors.of(context).fontColor),
    );
  }

  Widget _buildBusLineBox(String busLineName) {
    var _dayName = 'Robocze';
    if (widget.dayShortcut == 'WS') {
      _dayName = 'Soboty';
    } else if (widget.dayShortcut == 'SW') {
      _dayName = 'Święta';
    }
    return Container(
      width: 85.0,
      // height: 45.0,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_note_outlined,
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
            SizedBox(
              height: 3,
            ),
            Text(
              _dayName,
              style: TextStyle(fontSize: 11.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleTable() {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 10, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 2.5),
            physics: NeverScrollableScrollPhysics(),
            // to disable GridView's scrolling
            shrinkWrap: true,
            itemCount: widget.departures.length,
            itemBuilder: (BuildContext context, int index) {
              var departure = widget.departures[index];
              return TimeGridItem(departure: departure);
            },
          ),
          Container(
            height: 20.0,
          ),
          Text(
            'Legenda'.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: AppColors.of(context).headlineColor),
          ),
          if (widget.destinations.isEmpty)
            Text(
              'Brak oznaczeń dla linii na tym przystanku',
              style: TextStyle(fontSize: 14),
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.destinations.length,
            itemBuilder: (BuildContext context, int index) {
              var destination = widget.destinations[index];
              if (destination.symbol.contains('-')) {
                return SizedBox.shrink();
              }
              return Text(
                destination.scheduleName,
                style: TextStyle(
                    color: AppColors.of(context).fontColor, fontSize: 14),
              );
            },
          ),
        ],
      ),
    );
  }
}
