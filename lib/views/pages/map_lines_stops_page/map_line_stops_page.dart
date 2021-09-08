import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarbus_app/bloc/map_cubit/map_cubit.dart';
import 'package:tarbus_app/views/widgets/app_bars/pretty_title.dart';
import 'package:tarbus_app/views/widgets/map/map_widget.dart';

class MapLineStopsPage extends StatefulWidget {
  final int busLineId;
  final String busLineName;

  const MapLineStopsPage({
    Key? key,
    required this.busLineId,
    required this.busLineName,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapLineStopsPage();
}

class _MapLineStopsPage extends State<MapLineStopsPage> {
  @override
  void initState() {
    context.read<BusStopsLineMapCubit>().init(widget.busLineId);
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
          subTitle: ' Trasa linii ${widget.busLineName}',
        ),
      ),
      body: MapWidget<BusStopsLineMapCubit>(),
    );
  }
}
