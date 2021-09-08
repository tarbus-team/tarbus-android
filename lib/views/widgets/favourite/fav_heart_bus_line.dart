import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarbus_app/bloc/favourite_cubit/favourite_cubit.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';
import 'package:tarbus_app/data/storage/favourite_bus_lines_storage.dart';
import 'package:tarbus_app/data/storage_model/saved_bus_line_model.dart';
import 'package:tarbus_app/views/widgets/favourite/favourite_item_controller.dart';

class FavHeartBusLine extends StatefulWidget {
  final BusLine busLine;
  final FavItemController? controller;

  const FavHeartBusLine({Key? key, required this.busLine, this.controller})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavHeartBusStop();
}

class _FavHeartBusStop extends State<FavHeartBusLine> {
  bool isFavourite = false;
  bool isLoading = false;

  @override
  void initState() {
    setUpView();
    super.initState();
  }

  Future<void> updateFavourite(dynamic item) async {
    if (isLoading) return;
    isLoading = true;
    var prevFavState = isFavourite;
    setState(() {
      isFavourite = !isFavourite;
    });
    try {
      await context
          .read<FavouriteBusLinesCubit>()
          .addToFavourites(SavedBusLineModel.fromScheduleModel(item));
      await context.read<FavouriteBusLinesCubit>().getFavourites();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Pomyślnie zaktualizowano ulubioną linię autobusową!'),
      ));
      isLoading = false;
    } catch (_) {
      setState(() {
        isLoading = false;
        isFavourite = prevFavState;
      });
    }
  }

  Future<void> setUpView() async {
    bool _isFavourite = await FavouriteBusLinesStorage.contains(
        SavedBusLineModel.fromScheduleModel(widget.busLine).identity!);
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
      onPressed: null,
      icon: buildIcon(),
    );
  }
}
