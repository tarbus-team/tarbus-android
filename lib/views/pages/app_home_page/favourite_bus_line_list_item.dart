import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/storage_model/saved_bus_line_model.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';

class FavouriteBusLineListItem extends StatelessWidget {
  final SavedBusLineModel busLine;
  final bool isLast;

  const FavouriteBusLineListItem(
      {Key? key, required this.busLine, required this.isLast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.root.push(LineDetailsRoute(
            busLineId: busLine.id!, busLineName: busLine.realLineName!));
      },
      child: Container(
        decoration: BoxDecoration(
          border: !isLast
              ? Border(
                  bottom: BorderSide(
                  color: AppColors.of(context).borderColor,
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
            busLine.realLineName!,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                fontSize: 16, color: AppColors.of(context).headlineColor),
          ),
          subtitle: Text(
            busLine.realCompanyName!,
            style: TextStyle(fontSize: 14),
          ),
          leading: SizedBox(
            width: 30,
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/icon_bus.svg',
                color: AppColors.of(context).fontColor,
                width: 20,
                height: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
