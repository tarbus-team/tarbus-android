import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tarbus_app/bloc/routes_cubit/routes_cubit.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';
import 'package:tarbus_app/data/model/schedule/track_route.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';
import 'package:tarbus_app/views/widgets/app_bars/custom_app_bar.dart';
import 'package:tarbus_app/views/widgets/app_custom/action_tile.dart';
import 'package:tarbus_app/views/widgets/app_custom/custom_card.dart';

import 'line_details_list_item.dart';

class LineDetailsPage extends StatefulWidget {
  final int busLineId;
  final String busLineName;

  const LineDetailsPage(
      {Key? key, required this.busLineId, required this.busLineName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LineDetailsPage();
}

class _LineDetailsPage extends State<LineDetailsPage> {
  @override
  void initState() {
    context.read<RoutesCubit>().getAllByLine(widget.busLineId);
    super.initState();
  }

  Widget _buildItemsList(List<Map<String, dynamic>> data) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return LineDetailsListItem(
          busStops: data[index]['bus_stops'] as List<BusStop>,
          trackRoute: data[index]['route'] as TrackRoute,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Linia ${widget.busLineName}',
      ),
      body: ListView(
        children: [
          CustomCard(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Text('Akcje'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline3),
              ),
              ActionTile(
                title: 'Zobacz przystanki linii na mapie',
                onTap: () {
                  context.router.root.push(MapLineStopsRoute(
                      busLineId: widget.busLineId,
                      busLineName: widget.busLineName));
                },
              )
            ],
          )),
          CustomCard(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text('Kierunki'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline3),
              ),
              BlocBuilder<RoutesCubit, RoutesState>(
                builder: (context, state) {
                  if (state is RoutesLoaded) {
                    return _buildItemsList(state.data);
                  }
                  return Text('Loading');
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
