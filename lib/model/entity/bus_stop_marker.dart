import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:tarbus2021/model/entity/bus_stop.dart';

class BusStopMarker implements Marker {
  final BusStop busStop;
  final LatLng bpoint;
  final WidgetBuilder bbuilder;
  final double bwidth;
  final double bheight;
  final Anchor banchor;

  BusStopMarker(
      {this.busStop, this.bpoint, this.bbuilder, this.bwidth = 30.0, this.bheight = 30.0, AnchorPos anchorPos})
      : banchor = Anchor.forPos(anchorPos, bwidth, bheight);

  @override
  Anchor get anchor => banchor;

  @override
  WidgetBuilder get builder => bbuilder;

  @override
  double get height => bheight;

  @override
  LatLng get point => bpoint;

  @override
  double get width => bwidth;
}
