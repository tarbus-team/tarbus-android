import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/shared/utilities/date_time_utils.dart';

class DeparturesDayBreakpoint extends StatelessWidget {
  final int daysAhead;

  const DeparturesDayBreakpoint({
    Key? key,
    required this.daysAhead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todayDate = DateTime.now();
    todayDate = todayDate.add(Duration(days: daysAhead));

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
            DateTimeUtils.getNamedDate(todayDate.add(Duration(days: 0))),
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
    );
  }
}
