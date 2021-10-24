import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/shared/utilities/date_time_utils.dart';

class DeparturesDayBreakpoint extends StatelessWidget {
  final DateTime time;

  const DeparturesDayBreakpoint({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            DateTimeUtils.getNamedDate(time),
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
    );
  }
}
