import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/model/entity/bus_stop.dart';
import 'package:tarbus2021/src/model/entity/bus_stop_arguments_holder.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/favourites_bus_stop_icon.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/nothing.dart';
import 'package:tarbus2021/src/presentation/views/schedule/factory_schedule_view.dart';

class SearchItemBusStop extends StatelessWidget {
  final BusStop busStop;
  final bool showFavouritesButton;

  const SearchItemBusStop({Key key, this.busStop, this.showFavouritesButton = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          if (!showFavouritesButton) {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamed(FactoryScheduleView.route, arguments: BusStopArgumentsHolder(busStop: busStop));
          }
        },
        title: Text(busStop.name),
        subtitle: Row(
          children: [
            Icon(
              Icons.arrow_forward,
              color: AppColors.instance(context).iconColor,
              size: 20,
            ),
            Expanded(
                child: Text(
              busStop.destinations == null ? "-" : busStop.destinations,
              maxLines: 2,
              style: TextStyle(color: AppColors.instance(context).iconColor, fontStyle: FontStyle.italic),
            )),
          ],
        ),
        trailing: showFavouritesButton
            ? FavouritesBusStopIcon(
                busStop: busStop,
              )
            : Nothing(),
      ),
    );
  }
}
