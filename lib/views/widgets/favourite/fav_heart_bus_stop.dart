import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarbus_app/bloc/favourite_cubit/favourite_cubit.dart';
import 'package:tarbus_app/bloc/search_cubit/search_cubit.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';
import 'package:tarbus_app/data/storage/favourite_bus_stop_storage.dart';
import 'package:tarbus_app/data/storage_model/saved_bus_stop_model.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';
import 'package:tarbus_app/views/widgets/favourite/favourite_item_controller.dart';

class FavHeartBusStop extends StatefulWidget {
  final BusStop busStop;
  final FavItemController? controller;

  const FavHeartBusStop({Key? key, required this.busStop, this.controller})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavHeartBusStop();
}

class _FavHeartBusStop extends State<FavHeartBusStop> {
  bool isFavourite = false;

  @override
  void initState() {
    setUpView();
    super.initState();
  }

  Future<void> updateFavourite(dynamic item) async {
    if (await FavouriteBusStopsStorage.contains(item.id)) {
      SavedBusStopModel cachedRemoved =
          (await FavouriteBusStopsStorage.getById(item.id))!;
      FavouriteBusStopsStorage.remove(item.id);
      await context.read<FavouriteBusStopsCubit>().getFavourites();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Pomyślnie skasowano przystanek autobusowy!'),
        action: SnackBarAction(
          label: 'Cofnij',
          onPressed: () async {
            FavouriteBusStopsStorage.putNew(cachedRemoved);
            await context.read<FavouriteBusStopsCubit>().getFavourites();
            await context.read<SearchCubit>().refresh();
          },
        ),
      ));
      setState(() {
        isFavourite = false;
      });
    } else {
      context.router.push(AddFavouriteBusStopRoute(busStop: item));
    }
  }

  Future<void> setUpView() async {
    bool _isFavourite =
        await FavouriteBusStopsStorage.contains(widget.busStop.id);
    setState(() {
      isFavourite = _isFavourite;
    });
  }

  Icon buildIcon() {
    if (isFavourite) {
      return Icon(
        CupertinoIcons.heart_solid,
        color: AppColors.of(context).primaryColor,
      );
    } else {
      return Icon(
        CupertinoIcons.heart,
        color: AppColors.of(context).primaryColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller != null) {
      widget.controller!.setUpController(updateFavourite);
    }

    return IconButton(
      onPressed: widget.controller != null
          ? null
          : () {
              updateFavourite(widget.busStop);
            },
      icon: buildIcon(),
    );
  }
}
