import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';
import 'package:tarbus_app/views/widgets/favourite/fav_heart_bus_stop.dart';
import 'package:tarbus_app/views/widgets/favourite/favourite_item_controller.dart';

class SearchListItemStop extends StatelessWidget {
  final BusStop busStop;
  final bool wantsFavourite;

  const SearchListItemStop(
      {Key? key, required this.busStop, required this.wantsFavourite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavItemController controller = FavItemController();

    Future<void> onAddToFavourite() async {
      await controller.updateFavourite!(busStop);
    }

    return InkWell(
      onTap: () {
        if (wantsFavourite) {
          onAddToFavourite();
        } else {
          context.router.push(DeparturesRoute(
              busStopId: busStop.id, busStopName: busStop.name));
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
          trailing: wantsFavourite
              ? FavHeartBusStop(
                  busStop: busStop,
                  controller: controller,
                )
              : Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
        ),
      ),
    );
  }
}
