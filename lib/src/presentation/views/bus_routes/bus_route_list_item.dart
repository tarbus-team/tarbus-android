import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/app/settings.dart';
import 'package:tarbus2021/src/model/entity/bus_stop_arguments_holder.dart';
import 'package:tarbus2021/src/model/entity/route_holder.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/clear_button.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/nothing.dart';
import 'package:tarbus2021/src/presentation/views/bus_routes/controller/bus_route_list_item_controller.dart';
import 'package:tarbus2021/src/presentation/views/schedule/factory_schedule_view.dart';

class BusRouteListItem extends StatefulWidget {
  final RouteHolder routeHolder;

  BusRouteListItem({this.routeHolder});

  @override
  _BusRouteListItemState createState() => _BusRouteListItemState();
}

class _BusRouteListItemState extends State<BusRouteListItem> with TickerProviderStateMixin {
  BusRouteListItemController viewController = BusRouteListItemController();
  bool isTrackVisible = false;
  TextOverflow _textOverflow = TextOverflow.ellipsis;

  @override
  Widget build(BuildContext context) {
    String destinationName = Settings.isDevelop
        ? 'id: ${widget.routeHolder.trackRoute.id} - name: ${widget.routeHolder.trackRoute.destinationName}'
        : '${widget.routeHolder.trackRoute.destinationName}';

    return Container(
      width: double.infinity,
      child: Card(
        child: Column(
          children: [
            ListTile(
              isThreeLine: isTrackVisible,
              onTap: () {
                setState(() {
                  isTrackVisible = !isTrackVisible;
                  if (isTrackVisible) {
                    _textOverflow = TextOverflow.clip;
                  } else {
                    _textOverflow = TextOverflow.ellipsis;
                  }
                });
              },
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text('kier.')],
              ),
              title: Text(destinationName),
              subtitle: Text(
                widget.routeHolder.trackRoute.destinationDesc,
                overflow: _textOverflow,
              ),
              trailing: Icon(
                _buildArrowIcon(),
                color: AppColors.instance(context).iconColor,
              ),
            ),
            AnimatedSize(
              vsync: this,
              alignment: Alignment.bottomCenter,
              duration: Duration(milliseconds: 300),
              curve: Curves.fastLinearToSlowEaseIn,
              child: Wrap(
                children: [
                  _buildTrackList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _buildArrowIcon() {
    if (isTrackVisible) {
      return Icons.keyboard_arrow_up;
    }
    return Icons.keyboard_arrow_down;
  }

  Widget _buildTrackList() {
    if (isTrackVisible) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.margin_view_horizontally, vertical: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trasa',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.routeHolder.busStops.length,
              itemBuilder: (BuildContext context, int index) {
                var busStop = widget.routeHolder.busStops[index];
                return ClearButton(
                  button: FlatButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pushNamed(FactoryScheduleView.route,
                          arguments: BusStopArgumentsHolder(busStop: busStop, busLineFilter: widget.routeHolder.trackRoute.busLine.name));
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
            ),
          ],
        ),
      );
    } else {
      return Nothing();
    }
  }

  Widget _getBusStopName(var name, var isOptional) {
    if (isOptional) {
      return Text(
        '...$name',
        style: TextStyle(fontWeight: FontWeight.normal, fontStyle: FontStyle.italic, color: AppColors.instance(context).iconColor),
      );
    } else {
      return Text(
        name,
        style: TextStyle(fontWeight: FontWeight.normal, color: AppColors.instance(context).mainFontColor),
      );
    }
  }
}
