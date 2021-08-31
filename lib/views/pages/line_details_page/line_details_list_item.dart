import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';
import 'package:tarbus_app/data/model/schedule/track_route.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';
import 'package:tarbus_app/views/widgets/generic/wants_ink_well.dart';

class LineDetailsListItem extends StatefulWidget {
  final TrackRoute trackRoute;
  final List<BusStop> busStops;

  const LineDetailsListItem(
      {Key? key, required this.trackRoute, required this.busStops})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LineDetailsListItem();
}

class _LineDetailsListItem extends State<LineDetailsListItem> {
  bool isCollapsed = false;

  _buildListItem(int? stopId, String text, int indexValue) {
    Map<int, Widget> imageValues = {
      0: SvgPicture.asset(
        'assets/icons/icon_pin_start.svg',
        height: 30,
      ),
      1: SvgPicture.asset(
        'assets/icons/icon_pin_middle.svg',
        height: 30,
      ),
      2: SvgPicture.asset(
        'assets/icons/icon_pin_end.svg',
        height: 30,
      ),
    };
    Map<int, TextStyle> textStyleValues = {
      0: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      1: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
      2: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    };
    return WantsInkWell(
      wantsInkWell: stopId != null,
      onTap: () {
        context.router.push(DeparturesRoute(
          busStopId: stopId!,
          busStopName: text,
          busLine: widget.trackRoute.busLine,
        ));
      },
      child: ListTile(
        dense: true,
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        contentPadding: EdgeInsets.all(0),
        leading: SizedBox(
          width: 20,
          child: imageValues[indexValue]!,
        ),
        minLeadingWidth: 20,
        title: Text(
          '$text',
          style: textStyleValues[indexValue],
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _getLongList() {
    return ListView.builder(
        itemCount: widget.busStops.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          BusStop busStop = widget.busStops[index];
          if (index == 0) {
            return _buildListItem(busStop.id, busStop.name, 0);
          } else if (index == widget.busStops.length - 1) {
            return _buildListItem(busStop.id, busStop.name, 2);
          } else {
            return _buildListItem(busStop.id, busStop.name, 1);
          }
        });
  }

  Widget _buildCollapseIcon() {
    return Center(
      child: Column(
        children: [
          Text(
            isCollapsed ? 'Zwiń' : 'Rozwiń',
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: 13,
                  color: Colors.black,
                ),
          ),
          if (isCollapsed)
            Icon(
              Icons.keyboard_arrow_up,
              size: 14,
            )
          else
            Icon(
              Icons.keyboard_arrow_down,
              size: 14,
            ),
        ],
      ),
    );
  }

  Widget _getShortList() {
    List<String> cities = widget.trackRoute.destinationDesc.split(",");
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildListItem(null, cities[0], 0);
          } else if (index == 1) {
            return _buildListItem(null, cities[(cities.length / 2).floor()], 1);
          } else {
            return _buildListItem(null, cities[cities.length - 1], 2);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        child: InkWell(
          onTap: () {
            setState(() {
              isCollapsed = !isCollapsed;
            });
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Cel',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        fontSize: 12,
                                        color: AppColors.of(context)
                                            .primaryLightDarker,
                                      )),
                              Text(widget.trackRoute.destinationName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        fontSize: 16,
                                        color: Colors.black,
                                      )),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              context.router.root.push(
                                  MapRouteStopsRoute(route: widget.trackRoute));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.map,
                                  color: AppColors.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  'Mapa',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: AppColors.of(context).primaryColor,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Text('Przez',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                fontSize: 12,
                                color: AppColors.of(context).primaryLightDarker,
                              )),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                if (!isCollapsed) _getShortList() else _getLongList(),
                SizedBox(
                  height: 10,
                ),
                _buildCollapseIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
