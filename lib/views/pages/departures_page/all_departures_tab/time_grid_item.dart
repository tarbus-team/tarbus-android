import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/data/model/schedule/departure.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';

class TimeGridItem extends StatelessWidget {
  final Departure departure;

  const TimeGridItem({Key? key, required this.departure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(DepartureDetailsRoute(departure: departure));
      },
      child: Row(
        children: [
          Text(
            departure.timeInString,
            style: TextStyle(fontSize: 15),
          ),
          Text(
            departure.destination.symbol == '-'
                ? ''
                : departure.destination.symbol,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
