import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/settings.dart';
import 'package:tarbus2021/src/app/widgets/horizontal_line.dart';
import 'package:tarbus2021/src/model/route_holder.dart';
import 'package:tarbus2021/src/views/schedule_view/factory_schedule_view.dart';

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
    String destinationName = Settings.isDevelop
        ? 'id: ${widget.routeHolder.destination.id} - name: ${widget.routeHolder.destination.name}'
        : '${widget.routeHolder.destination.name}';

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'kier.',
              style: TextStyle(fontFamily: 'Asap', fontWeight: FontWeight.bold),
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
                  width: MediaQuery.of(context).size.width * 0.77,
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destinationName,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Asap'),
                      ),
                      Text(
                        widget.routeHolder.destination.description,
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontFamily: 'Asap', fontStyle: FontStyle.italic),
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
              // TODO : Move it to viewController
              var busStop = widget.routeHolder.busStops[index];
              AssetImage trackIcon;
              if (index == 0) {
                trackIcon = AssetImage('assets/icons/first_bus_stop_icon_b.png');
              } else if (index == widget.routeHolder.busStops.length - 1) {
                trackIcon = AssetImage('assets/icons/last_bus_stop_icon_b.png');
              } else {
                trackIcon = AssetImage('assets/icons/next_bus_stop_icon_b.png');
              }

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
                      Image(image: trackIcon, height: 30, fit: BoxFit.fitHeight),
                      Container(
                        width: 8,
                      ),
                      Text(busStop.name),
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
    //return Text(routeHolder.destination.name);
  }
}
