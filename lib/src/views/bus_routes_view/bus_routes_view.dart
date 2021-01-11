import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/app/widgets/horizontal_line.dart';
import 'package:tarbus2021/src/model/bus_line.dart';
import 'package:tarbus2021/src/model/route_holder.dart';

import 'bus_route_list_item.dart';
import 'controller/bus_routes_view_controller.dart';

class BusRoutesView extends StatelessWidget {
  final BusLine busLine;
  final BusRoutesViewController viewController = BusRoutesViewController();

  BusRoutesView({Key key, this.busLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Linia - ${busLine.name}',
          style: TextStyle(fontFamily: 'Asap', fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(AppDimens.margin_view_horizontally),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Kierunki dla linii ${busLine.name}:\n',
                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Asap'),
              ),
              HorizontalLine(),
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
      ),
    );
  }
}
