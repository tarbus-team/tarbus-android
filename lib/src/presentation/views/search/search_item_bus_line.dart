import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/model/entity/bus_line.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/favourites_bus_line_icon.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/nothing.dart';
import 'package:tarbus2021/src/presentation/views/bus_routes/bus_routes_view.dart';

class SearchItemBusLine extends StatelessWidget {
  final BusLine busLine;
  final bool showFavouritesButton;

  const SearchItemBusLine({Key key, this.busLine, this.showFavouritesButton = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          if (!showFavouritesButton) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder<void>(
                pageBuilder: (context, animation1, animation2) {
                  return BusRoutesView(busLine: busLine);
                },
                transitionsBuilder: (context, animation1, animation2, child) {
                  return FadeTransition(
                    opacity: animation1,
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 150),
              ),
            );
          }
        },
        title: Text(busLine.name),
        subtitle: Text(AppString.companyMichalus),
        trailing: showFavouritesButton
            ? FavouritesBusLineIcon(
                busLineId: busLine.id.toString(),
              )
            : Nothing(),
      ),
    );
  }
}
