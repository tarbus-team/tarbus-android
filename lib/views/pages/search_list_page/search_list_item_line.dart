import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';
import 'package:tarbus_app/views/widgets/favourite/fav_heart_bus_line.dart';
import 'package:tarbus_app/views/widgets/favourite/favourite_item_controller.dart';

class SearchListItemLine extends StatelessWidget {
  final BusLine busLine;
  final bool wantsFavourite;

  const SearchListItemLine(
      {Key? key, required this.busLine, required this.wantsFavourite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavItemController controller = FavItemController();

    Future<void> onAddToFavourite() async {
      await controller.updateFavourite!(busLine);
    }

    return InkWell(
      onTap: () {
        if (wantsFavourite) {
          onAddToFavourite();
        } else {
          context.router.push(LineDetailsRoute(
              busLineName: busLine.name, busLineId: busLine.id));
        }
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 1,
          color: AppColors.of(context).primaryLight,
        ))),
        child: ListTile(
            title: Text(
              busLine.name,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              busLine.version.company.name,
              style: TextStyle(fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
            dense: true,
            trailing: FavHeartBusLine(
              controller: wantsFavourite ? controller : null,
              busLine: busLine,
            )),
      ),
    );
  }
}
