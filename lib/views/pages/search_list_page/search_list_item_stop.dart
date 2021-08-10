import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';

class SearchListItemStop extends StatelessWidget {
  final BusStop busStop;
  final Function(BusStop item) onBusStopSelected;

  const SearchListItemStop(
      {Key? key, required this.busStop, required this.onBusStopSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onBusStopSelected(busStop),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 1,
          color: AppColors.of(context).primaryLight,
        ))),
        child: ListTile(
          title: Text(
            busStop.name,
            style: TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            busStop.destinations,
            style: TextStyle(fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
          dense: true,
          trailing: Icon(
            CupertinoIcons.heart,
            color: AppColors.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
