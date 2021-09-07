import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/storage_model/saved_bus_stop_model.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';

class FavouriteBusStopListItem extends StatelessWidget {
  final SavedBusStopModel busStop;
  final bool isLast;

  const FavouriteBusStopListItem(
      {Key? key, required this.busStop, required this.isLast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.navigate(
          DeparturesRoute(
            busStopId: busStop.id!,
            busStopName: busStop.realBusStopName,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: !isLast
              ? Border(
                  bottom: BorderSide(
                  color: AppColors.of(context).primaryLight,
                  width: 1,
                ))
              : null,
        ),
        child: ListTile(
          minLeadingWidth: 20,
          dense: true,
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 15,
          ),
          title: Text(
            busStop.userBusStopName!,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontSize: 16, color: AppColors.of(context).fontColor),
          ),
          subtitle: Text(
            busStop.realBusStopName!,
            style: TextStyle(fontSize: 14),
          ),
          leading: SizedBox(
            width: 30,
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/icon_bus_stop.svg',
                width: 26,
                height: 26,
                color: AppColors.of(context).fontColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
