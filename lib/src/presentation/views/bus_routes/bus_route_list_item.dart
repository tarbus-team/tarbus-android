import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/app/settings.dart';
import 'package:tarbus2021/src/model/entity/route_holder.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/horizontal_line.dart';
import 'package:tarbus2021/src/presentation/views/bus_routes/controller/bus_route_list_item_controller.dart';
import 'package:tarbus2021/src/presentation/views/schedule/factory_schedule_view.dart';

class BusRouteListItem extends StatefulWidget {
  final RouteHolder routeHolder;

  BusRouteListItem({this.routeHolder});

  @override
  _BusRouteListItemState createState() => _BusRouteListItemState();
}

class _BusRouteListItemState extends State<BusRouteListItem> {
  bool isTrackVisible = false;

  @override
  Widget build(BuildContext context) {
    BusRouteListItemController viewController = BusRouteListItemController();

    String destinationName = Settings.isDevelop
        ? 'id: ${widget.routeHolder.trackRoute.id} - name: ${widget.routeHolder.trackRoute.destinationName}'
        : '${widget.routeHolder.trackRoute.destinationName}';

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppString.labelDestinationShortcut,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  isTrackVisible = !isTrackVisible;
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destinationName,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.routeHolder.trackRoute.destinationName,
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontStyle: FontStyle.italic),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (isTrackVisible)
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.routeHolder.busStops.length,
            itemBuilder: (BuildContext context, int index) {
              var busStop = widget.routeHolder.busStops[index];

              return ButtonTheme(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), //adds padding inside the button
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, //limits the touch area to the button area
                minWidth: 0, //wraps child's width
                height: 0, //wraps child's height
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FactoryScheduleView(busStop: busStop)));
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                          image: AssetImage(viewController.getBusStopIconPath(index, widget.routeHolder.busStops.length)),
                          height: 30,
                          fit: BoxFit.fitHeight),
                      Container(
                        width: 8,
                      ),
                      _getBusStopName(busStop.name, busStop.isOptional),
                    ],
                  ),
                ),
              );
            },
          )
        else
          Container(
            width: 0,
            height: 0,
          ),
        HorizontalLine(),
      ],
    );
  }

  Widget _getBusStopName(var name, var isOptional) {
    if (isOptional) {
      return Text(
        '...$name',
        style: TextStyle(fontStyle: FontStyle.italic),
      );
    } else {
      return Text(name);
    }
  }
}
