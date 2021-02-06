import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/model/entity/bus_stop.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/favourites_bus_stop_dialog.dart';
import 'package:tarbus2021/src/utils/favourites_bus_stop_utils.dart';

class FavouritesBusStopIcon extends StatefulWidget {
  final BusStop busStop;

  const FavouritesBusStopIcon({Key key, this.busStop}) : super(key: key);

  @override
  _FavouritesBusStopIconState createState() => _FavouritesBusStopIconState();
}

class _FavouritesBusStopIconState extends State<FavouritesBusStopIcon> {
  bool isFavourite = false;

  @override
  void initState() {
    update();

    super.initState();
  }

  void update() async {
    isFavourite = await FavouritesBusStopUtils.checkIfExist(widget.busStop.id.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isFavourite) {
      return IconButton(
        icon: Icon(Icons.favorite),
        onPressed: () async {
          if (await FavouritesBusStopUtils.removeFavouriteBusStop(widget.busStop.id.toString())) {
            setState(() {
              isFavourite = false;
            });
          }
        },
      );
    } else {
      return IconButton(
        icon: Icon(Icons.favorite_border),
        onPressed: () async {
          var operationStatus = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavouritesBusStopDialog(
                busStop: widget.busStop,
              ),
            ),
          );
          if (operationStatus) {
            update();
          }
        },
      );
    }
  }
}
