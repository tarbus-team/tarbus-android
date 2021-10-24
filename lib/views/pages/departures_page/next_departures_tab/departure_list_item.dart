import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/departure_wrapper.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';
import 'package:tarbus_app/shared/utilities/date_time_utils.dart';
import 'package:tarbus_app/views/widgets/schedule/bus_line_container.dart';
import 'package:tarbus_app/views/widgets/schedule/departures_day_breakpoint.dart';

class DepartureListItem extends StatelessWidget {
  final DepartureWrapper departureWrapper;

  const DepartureListItem({
    Key? key,
    required this.departureWrapper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _getTimeName() {
      if (departureWrapper.isLive) {
        return departureWrapper.remoteDeparture!.minutes;
      }
      return DateTimeUtils.parseMinutesToTime(
          departureWrapper.departure.timeInMin);
    }

    Widget _buildSubtitle() {
      if (departureWrapper.isLive)
        return Text(
          'LIVE',
          style: Theme.of(context).textTheme.headline3!.copyWith(
                color: Colors.red,
              ),
        );
      if (departureWrapper.daysAhead != 0)
        return Text(
          DateTimeUtils.getDepartureDayShortcut(
              departureWrapper.departureDate, departureWrapper.daysAhead),
          style: Theme.of(context).textTheme.headline3!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        );
      return SizedBox.shrink();
    }

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
                context.router.push(
                  DepartureDetailsRoute(
                    departureWrapper: departureWrapper,
                  ),
                );
              },
              child: ListTile(
                dense: true,
                visualDensity: VisualDensity.comfortable,
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                title: Text(
                  departureWrapper.trackName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.w500,
                    color: AppColors.of(context).fontColor,
                  ),
                ),
                leading: BusLineContainer(
                  busLineName:
                      departureWrapper.departure.track.route.busLine.name,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      child: Text(
                        _getTimeName(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.of(context).headlineColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    _buildSubtitle(),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (departureWrapper.isBreakpoint)
          DeparturesDayBreakpoint(
            time: departureWrapper.departureDate,
          ),
      ],
    );
  }
}
