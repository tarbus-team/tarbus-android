import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/bloc/map_cubit/map_cubit.dart';
import 'package:tarbus_app/views/widgets/app_bars/pretty_title.dart';
import 'package:tarbus_app/views/widgets/map/map_widget.dart';

class AppMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppMapPage();
}

class _AppMapPage extends State<AppMapPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PrettyTitle(
          bigSize: 20,
          smallSize: 12,
          title: 'Mapa',
          subTitle: ' Przystanki autobusowe',
        ),
      ),
      body: MapWidget<BusStopsMapCubit>(),
    );
  }
}
