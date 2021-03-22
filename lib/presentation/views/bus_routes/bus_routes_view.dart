import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/app/app_string.dart';
import 'package:tarbus2021/model/entity/bus_line.dart';
import 'package:tarbus2021/model/entity/route_holder.dart';
import 'package:tarbus2021/presentation/custom_widgets/appbar_title.dart';
import 'package:tarbus2021/presentation/custom_widgets/favourites_bus_line_icon.dart';

import 'bus_route_list_item.dart';
import 'controller/bus_routes_view_controller.dart';

class BusRoutesView extends StatelessWidget {
  static const route = '/busLines/busRoute';
  final BusLine busLine;
  final BusRoutesViewController viewController = BusRoutesViewController();

  BusRoutesView({Key key, this.busLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          FavouritesBusLineIcon(
            busLineId: busLine.id.toString(),
          ),
        ],
        title: Row(
          children: [
            AppBarTitle(
              title: '${AppString.labelBusLine} - ${busLine.name}',
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Kierunki dla linii ${busLine.name}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Michalus'),
            ),
            FutureBuilder<List<RouteHolder>>(
              future: viewController.getAllDeparturesByLineId(busLine.id),
              builder: (BuildContext context, AsyncSnapshot<List<RouteHolder>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var routeHolder = snapshot.data[index];
                      routeHolder.trackRoute.busLine = busLine;
                      return BusRouteListItem(routeHolder: routeHolder);
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
