import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarbus_app/bloc/map_cubit/map_cubit.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';
import 'package:tarbus_app/data/model/schedule/track.dart';
import 'package:tarbus_app/views/widgets/app_custom/map_widget.dart';
import 'package:tarbus_app/views/widgets/app_custom/pretty_title.dart';

class TrackMapPage extends StatefulWidget {
  final Track track;
  final BusStop busStop;

  const TrackMapPage({Key? key, required this.track, required this.busStop})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TrackMapPage();
}

class _TrackMapPage extends State<TrackMapPage> {
  @override
  void initState() {
    context.read<TrackMapCubit>().initTrackMap(widget.track, widget.busStop);
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
          subTitle: ' Trasa linii ${widget.track.route.busLine.name}',
        ),
      ),
      body: MapWidget<TrackMapCubit>(),
    );
  }
}
