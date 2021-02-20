import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_consts.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/model/entity/bus_stop.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/favourites_bus_stop_dialog.dart';
import 'package:tarbus2021/src/utils/shared_preferences_utils.dart';

class FavouritesBusStopIcon extends StatefulWidget {
  final BusStop busStop;

  const FavouritesBusStopIcon({this.busStop});

  @override
  _FavouritesBusStopIconState createState() => _FavouritesBusStopIconState();
}

class _FavouritesBusStopIconState extends State<FavouritesBusStopIcon> {
  bool isFavourite = false;

  @override
  void didUpdateWidget(covariant FavouritesBusStopIcon oldWidget) {
    update();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    update();
    super.initState();
  }

  void update() async {
    isFavourite = await SharedPreferencesUtils.checkIfExistByIndex(AppConsts.SharedPreferencesFavStop, widget.busStop.id.toString(), 0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isFavourite)
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () async {
              if (await SharedPreferencesUtils.removeByIndex(AppConsts.SharedPreferencesFavStop, widget.busStop.id.toString(), 0)) {
                setState(() {
                  isFavourite = false;
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(AppString.labelRemovedBusStopFromFav),
                  ));
                });
              }
            },
          ),
        if (!isFavourite)
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () async {
              var operationStatus = await Navigator.push(
                context,
                MaterialPageRoute<bool>(
                  builder: (context) => FavouritesBusStopDialog(
                    busStop: widget.busStop,
                  ),
                ),
              );
              if (operationStatus) {
                update();
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(AppString.labelAddedBusStopToFav),
                ));
              }
            },
          ),
      ],
    );
  }
}
