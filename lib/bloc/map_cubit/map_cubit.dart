import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:latlong2/latlong.dart';
import 'package:tarbus_app/bloc/gps_cubit/gps_cubit.dart';
import 'package:tarbus_app/data/local/bus_stops_connection_database.dart';
import 'package:tarbus_app/data/local/bus_stops_database.dart';
import 'package:tarbus_app/data/model/bus_stop_marker.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop_connection.dart';
import 'package:tarbus_app/data/model/schedule/track.dart';
import 'package:tarbus_app/shared/location_controller.dart';

part 'map_state.dart';

abstract class MapCubit extends Cubit<MapState> {
  final GpsCubit gpsCubit;

  MapCubit({required this.gpsCubit}) : super(MapInitial());

  final defaultMapCenter = LatLng(50.02, 20.94);

  bool _permission = false;

  Future<void> initMap(
      MapController mapController, PopupController popupController) async {
    emit(MapLoading());

    List<Marker> markers = await getMarkers();
    List<LatLng> polypoints = await getPolylines();
    LatLng mapCenter = await getMapCenter() ?? defaultMapCenter;
    emit(MapLoaded(
        mapCenter: mapCenter,
        zoom: getZoom(),
        markers: markers,
        polypoints: polypoints,
        permission: _permission));
  }

  double getZoom() {
    return 15;
  }

  Future<LatLng?> getMapCenter() async {
    if (await LocationController.canGetPosition()) {
      Geolocator.Position? position = await gpsCubit.getPosition();
      _permission = true;
      return LatLng(position!.latitude, position.longitude);
    }
    _permission = false;
    return null;
  }

  List<Marker> getBusStopMarkers(List<BusStop> busStopsList) {
    List<Marker> markers = List.empty(growable: true);
    busStopsList.forEach((busStop) {
      markers.add(
        BusStopMarker(
          busStop: busStop,
          bWidth: 50.0,
          bHeight: 50.0,
          bPoint: LatLng(busStop.lat!, busStop.lng!),
          bBuilder: (ctx) => Container(
            child: Image(image: AssetImage('assets/icons/bs-point-0.png')),
          ),
          bAnchor: Anchor.forPos(AnchorPos.align(AnchorAlign.center), 50, 50),
        ),
      );
    });
    return markers;
  }

  Future<List<Marker>> getMarkers();

  Future<List<LatLng>> getPolylines();
}

class BusStopsMapCubit extends MapCubit {
  final GpsCubit gpsCubit;

  BusStopsMapCubit({required this.gpsCubit}) : super(gpsCubit: gpsCubit);

  @override
  Future<List<Marker>> getMarkers() async {
    List<Marker> markers = List.empty(growable: true);
    await BusStopsDatabase.getAllBusStops().then((busStopList) {
      markers = getBusStopMarkers(busStopList);
    });
    return markers;
  }

  @override
  Future<List<LatLng>> getPolylines() async {
    return List<LatLng>.empty(growable: true);
  }
}

class BusStopsLineMapCubit extends MapCubit {
  final GpsCubit gpsCubit;

  BusStopsLineMapCubit({required this.gpsCubit}) : super(gpsCubit: gpsCubit);

  int lineId = 0;

  Future<void> init(int lineId) async {
    this.lineId = lineId;
  }

  @override
  double getZoom() {
    return 11;
  }

  @override
  Future<LatLng?> getMapCenter() async {
    List<BusStop> busStops = await BusStopsDatabase.getBusStopsForLine(lineId);
    BusStop busStop = busStops[busStops.length ~/ 2];
    return LatLng(busStop.lat!, busStop.lng!);
  }

  @override
  Future<List<Marker>> getMarkers() async {
    List<Marker> markers = List.empty(growable: true);
    await BusStopsDatabase.getBusStopsForLine(lineId).then((busStopList) {
      markers = getBusStopMarkers(busStopList);
    });
    return markers;
  }

  @override
  Future<List<LatLng>> getPolylines() async {
    return List<LatLng>.empty(growable: true);
  }
}

class BusStopsRouteMapCubit extends MapCubit {
  final GpsCubit gpsCubit;

  BusStopsRouteMapCubit({required this.gpsCubit}) : super(gpsCubit: gpsCubit);

  int routeId = 0;

  Future<void> init(int routeId) async {
    this.routeId = routeId;
  }

  @override
  double getZoom() {
    return 11;
  }

  @override
  Future<LatLng?> getMapCenter() async {
    List<BusStop> busStops =
        await BusStopsDatabase.getBusStopsForRoute(routeId);
    BusStop busStop = busStops[busStops.length ~/ 2];
    return LatLng(busStop.lat!, busStop.lng!);
  }

  @override
  Future<List<Marker>> getMarkers() async {
    List<Marker> markers = List.empty(growable: true);
    await BusStopsDatabase.getBusStopsForRoute(routeId).then((busStopList) {
      markers = getBusStopMarkers(busStopList);
    });
    return markers;
  }

  @override
  Future<List<LatLng>> getPolylines() async {
    return List<LatLng>.empty(growable: true);
  }
}

class TrackMapCubit extends MapCubit {
  final GpsCubit gpsCubit;

  TrackMapCubit({required this.gpsCubit}) : super(gpsCubit: gpsCubit);

  Track? track;
  BusStop? currentBusStop;
  List<BusStop> busStopList = List.empty(growable: true);

  Future<void> initTrackMap(Track track, BusStop currentStop) async {
    this.track = track;
    this.currentBusStop = currentStop;
    busStopList = List.empty(growable: true);
  }

  @override
  Future<List<Marker>> getMarkers() async {
    List<Marker> markers = List.empty(growable: true);
    await BusStopsDatabase.getBusStopsForTrack(track!.id).then((busStopList) {
      this.busStopList = busStopList;
      markers = getBusStopMarkers(busStopList);
    });
    return markers;
  }

  @override
  Future<LatLng?> getMapCenter() async {
    return LatLng(currentBusStop!.lat!, currentBusStop!.lng!);
  }

  @override
  Future<List<LatLng>> getPolylines() async {
    List<LatLng> polypoints = List<LatLng>.empty(growable: true);
    for (int i = 0; i < busStopList.length - 1; i++) {
      BusStopConnection connection =
          await BusStopsConnectionDatabase.getConnection(
              busStopList[i], busStopList[i + 1]);
      // print(connection.startBusStop);
      List<String> trackPoints =
          connection.coords != null ? connection.coords!.split(',') : [];
      for (int j = 0; j < trackPoints.length; j += 2) {
        try {
          polypoints.add(LatLng(
              double.parse(trackPoints[j + 1].replaceAll(' ', '')),
              double.parse(trackPoints[j].replaceAll(' ', ''))));
        } catch (e) {
          polypoints.add(LatLng(
              connection.startBusStop!.lat!, connection.startBusStop!.lng!));
          polypoints.add(
              LatLng(connection.endBusStop!.lat!, connection.endBusStop!.lng!));
        }
      }
    }
    return polypoints;
  }
}
