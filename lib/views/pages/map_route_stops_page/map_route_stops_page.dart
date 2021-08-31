import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarbus_app/bloc/map_cubit/map_cubit.dart';
import 'package:tarbus_app/data/model/schedule/track_route.dart';
import 'package:tarbus_app/views/widgets/app_custom/map_widget.dart';
import 'package:tarbus_app/views/widgets/app_custom/pretty_title.dart';

class MapRouteStopsPage extends StatefulWidget {
  final TrackRoute route;

  const MapRouteStopsPage({Key? key, required this.route}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapRouteStopsPage();
}

class _MapRouteStopsPage extends State<MapRouteStopsPage> {
  @override
  void initState() {
    context.read<BusStopsRouteMapCubit>().init(widget.route.id);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PrettyTitle(
          bigSize: 20,
          smallSize: 12,
          title: 'Mapa',
          subTitle:
              ' Trasa trasy ${widget.route.busLine.name} - ${widget.route.destinationName}',
        ),
      ),
      body: MapWidget<BusStopsRouteMapCubit>(),
    );
  }
}
