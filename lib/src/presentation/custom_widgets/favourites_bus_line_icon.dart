import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_consts.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/utils/shared_preferences_utils.dart';

class FavouritesBusLineIcon extends StatefulWidget {
  final String busLineId;

  const FavouritesBusLineIcon({Key key, this.busLineId}) : super(key: key);
  @override
  _FavouritesBusLineIconState createState() => _FavouritesBusLineIconState();
}

class _FavouritesBusLineIconState extends State<FavouritesBusLineIcon> {
  bool _isFavourite = false;

  @override
  void initState() {
    update();
    super.initState();
  }

  void update() async {
    _isFavourite = await SharedPreferencesUtils.checkIfExist(AppConsts.SharedPreferencesFavLine, widget.busLineId);
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant FavouritesBusLineIcon oldWidget) {
    update();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_isFavourite) {
      return IconButton(
        icon: Icon(
          Icons.favorite,
        ),
        onPressed: () async {
          if (await SharedPreferencesUtils.remove(AppConsts.SharedPreferencesFavLine, widget.busLineId)) {
            setState(() {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(AppString.alertSucessufullyDeletedBusLine),
              ));
              _isFavourite = false;
            });
          }
        },
      );
    } else {
      return IconButton(
        icon: Icon(
          Icons.favorite_border,
        ),
        onPressed: () async {
          if (await SharedPreferencesUtils.add(AppConsts.SharedPreferencesFavLine, widget.busLineId)) {
            setState(() {
              _isFavourite = true;
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(AppString.alertSuccesfullyAddedToFavourites),
              ));
            });
          }
        },
      );
    }
  }
}
