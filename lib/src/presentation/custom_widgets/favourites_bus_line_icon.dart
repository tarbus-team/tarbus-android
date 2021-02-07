import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/utils/favourites_bus_line_utils.dart';

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
    _isFavourite = await FavouritesBusLineUtils.checkIfExist(widget.busLineId);
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
        icon: Icon(Icons.favorite),
        onPressed: () async {
          if (await FavouritesBusLineUtils.removeFavouriteBusLine(widget.busLineId)) {
            setState(() {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Usunięto z ulubionych!'),
              ));
              _isFavourite = false;
            });
          }
        },
      );
    } else {
      return IconButton(
        icon: Icon(Icons.favorite_border),
        onPressed: () async {
          if (await FavouritesBusLineUtils.addFavouriteBusLine(widget.busLineId)) {
            setState(() {
              _isFavourite = true;
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Dodano do ulubionych!'),
              ));
            });
          }
        },
      );
    }
  }
}
