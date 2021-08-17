import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';

class BusStopMarker implements Marker {
  final Key? bKey;
  final bool? bRotate;
  final BusStop busStop;
  final LatLng bPoint;
  final WidgetBuilder bBuilder;
  final double bWidth;
  final double bHeight;
  final Anchor bAnchor;
  final AlignmentGeometry? bRotateAlignment;
  final Offset? bRotateOrigin;

  BusStopMarker({
    this.bKey,
    this.bRotate,
    required this.busStop,
    required this.bPoint,
    required this.bBuilder,
    this.bWidth = 30,
    this.bHeight = 30,
    required this.bAnchor,
    this.bRotateAlignment,
    this.bRotateOrigin,
  });

  @override
  Anchor get anchor => bAnchor;

  @override
  WidgetBuilder get builder => bBuilder;

  @override
  double get height => bHeight;

  @override
  LatLng get point => bPoint;

  @override
  double get width => bWidth;

  @override
  Key? get key => bKey;

  @override
  bool? get rotate => bRotate;

  @override
  AlignmentGeometry? get rotateAlignment => bRotateAlignment;

  @override
  Offset? get rotateOrigin => bRotateOrigin;
}
