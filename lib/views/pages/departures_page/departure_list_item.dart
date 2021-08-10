import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/departure.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';
import 'package:tarbus_app/shared/utilities/date_time_utils.dart';

class DepartureListItem extends StatelessWidget {
  final Departure departure;
  final bool isBreakpoint;
  final int? daysAhead;

  const DepartureListItem({
    Key? key,
    required this.departure,
    required this.isBreakpoint,
    this.daysAhead = 0,
  }) : super(key: key);

  Widget _buildBreakpoint(BuildContext context, DateTime todayDate) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey.shade400),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateTimeUtils.getNamedDate(todayDate),
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ));
  }

  String _getDateUnderTime(DateTime todayDate) {
    switch (daysAhead) {
      case 1:
        return 'Jutro';
      case 2:
        return 'Pojutrze';
      default:
        todayDate = todayDate.add(Duration(days: -1));
        return DateTimeUtils.parseDate('dd.MM', todayDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    var todayDate = DateTime.now();
    todayDate = todayDate.add(Duration(days: daysAhead! + 1));

    return Wrap(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
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
                      color: Colors.black,
                    )),
                leading: Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/icon_bus.svg',
                        color: Colors.white,
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 43,
                        child: Text(
                          departure.track.route.busLine.name,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                        ),
                      )
                    ],
                  ),
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
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (daysAhead != 0)
                      Text(
                        _getDateUnderTime(todayDate),
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
        if (isBreakpoint) _buildBreakpoint(context, todayDate),
      ],
    );
  }
}
