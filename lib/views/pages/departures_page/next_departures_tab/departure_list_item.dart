import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/departure.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';
import 'package:tarbus_app/shared/utilities/date_time_utils.dart';
import 'package:tarbus_app/views/widgets/schedule/bus_line_container.dart';
import 'package:tarbus_app/views/widgets/schedule/departures_day_breakpoint.dart';

class DepartureListItem extends StatelessWidget {
  final Departure departure;
  final bool isBreakpoint;
  final int daysAhead;
  final int? nextDaysAhead;

  const DepartureListItem({
    Key? key,
    required this.departure,
    required this.isBreakpoint,
    this.daysAhead = 0,
    this.nextDaysAhead,
  }) : super(key: key);

  Widget _buildBreakpoint(BuildContext context) {
    if (nextDaysAhead == null) return SizedBox(height: 0);
    return DeparturesDayBreakpoint(daysAhead: nextDaysAhead!);
  }

  @override
  Widget build(BuildContext context) {
    var todayDate = DateTime.now();
    todayDate = todayDate.add(Duration(days: daysAhead));

    return Wrap(
      children: [
        SizedBox(
          height: 50,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                context.router
                    .push(DepartureDetailsRoute(departure: departure));
              },
              child: ListTile(
                dense: true,
                visualDensity: VisualDensity.comfortable,
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                title: Text(departure.destination.directionBoardName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.w500,
                      color: AppColors.of(context).fontColor,
                    )),
                leading: BusLineContainer(
                  busLineName: departure.track.route.busLine.name,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      child: Text(
                        DateTimeUtils.parseMinutesToTime(departure.timeInMin),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.of(context).fontColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (daysAhead != 0)
                      Text(
                        DateTimeUtils.getDepartureDayShortcut(
                            todayDate.add(Duration(days: 1)), daysAhead),
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isBreakpoint) _buildBreakpoint(context),
      ],
    );
  }
}
