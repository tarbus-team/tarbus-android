import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarbus2021/src/model/entity/bus_stop.dart';
import 'package:tarbus2021/src/utils/favourites_bus_stop_utils.dart';

import 'appbar_title.dart';

class FavouritesBusStopDialog extends StatelessWidget {
  final BusStop busStop;

  const FavouritesBusStopDialog({Key key, this.busStop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _busStopNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [
            AppBarTitle(title: 'Dodaj do ulubionych'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (await FavouritesBusStopUtils.addFavouriteBusStop(busStop.id.toString(), _busStopNameController.text)) {
                Navigator.of(context).pop(true);
              }
            },
            child: Text('ZAPISZ'),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(busStop.name),
          Row(
            children: [
              Text('Kierunki: '),
              Text(busStop.name),
            ],
          ),
          Text('${busStop.lat}, ${busStop.lng}'),
          TextFormField(
            controller: _busStopNameController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(15),
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Wpisz swoją nazwę dla przystanku',
            ),
          ),
        ],
      ),
    );
  }
}
