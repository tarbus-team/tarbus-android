import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/app/app_colors.dart';
import 'package:tarbus2021/app/app_dimens.dart';
import 'package:tarbus2021/app/app_string.dart';
import 'package:tarbus2021/app/settings.dart';
import 'package:tarbus2021/model/entity/bus_stop_arguments_holder.dart';
import 'package:tarbus2021/model/entity/route_holder.dart';
import 'package:tarbus2021/presentation/custom_widgets/clear_button.dart';
import 'package:tarbus2021/presentation/views/schedule/factory_schedule_view.dart';

import 'controller/bus_route_list_item_controller.dart';

class BusRouteListItem extends StatefulWidget {
  final RouteHolder routeHolder;

  BusRouteListItem({this.routeHolder});

  @override
  _BusRouteListItemState createState() => _BusRouteListItemState();
}

class _BusRouteListItemState extends State<BusRouteListItem> with TickerProviderStateMixin {
  BusRouteListItemController viewController = BusRouteListItemController();
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var destinationName = Settings.isDevelop
        ? 'id: ${widget.routeHolder.trackRoute.id} - name: ${widget.routeHolder.trackRoute.destinationName}'
        : widget.routeHolder.trackRoute.destinationName;

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Column(
          children: [
            ListTileTheme(
              dense: true,
              child: ExpansionTile(
                tilePadding: _isExpanded ? EdgeInsets.symmetric(vertical: 11, horizontal: 20) : EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text(AppString.labelDestinationShortcut)],
                ),
                title: Text(destinationName, style: TextStyle(fontSize: 20.0, color: AppColors.instance(context).mainFontColor)),
                onExpansionChanged: (status) {
                  setState(() {
                    _isExpanded = status;
                  });
                },
                subtitle: Text(
                  widget.routeHolder.trackRoute.destinationDesc,
                  style: TextStyle(color: AppColors.instance(context).mainFontColor),
                  overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                ),
                trailing: Icon(
                  _buildArrowIcon(),
                  color: AppColors.instance(context).iconColor,
                ),
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
    if (_isExpanded) {
      return Icons.keyboard_arrow_up;
    }
    return Icons.keyboard_arrow_down;
  }

  Widget _buildTrackList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.margin_view_horizontally, vertical: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppString.labelTrack,
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
  }

  Widget _getBusStopName(String name, bool isOptional) {
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
