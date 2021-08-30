import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:latlong2/latlong.dart';
import 'package:tarbus_app/bloc/gps_cubit/gps_cubit.dart';
import 'package:tarbus_app/data/local/bus_stops_connection_database.dart';
import 'package:tarbus_app/data/local/bus_stops_database.dart';
import 'package:tarbus_app/data/model/bus_stop_marker.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';
import 'package:tarbus_app/data/model/schedule/track.dart';
import 'package:tarbus_app/shared/location_controller.dart';

part 'map_state.dart';

abstract class MapCubit extends Cubit<MapState> {
  final GpsCubit gpsCubit;

  MapCubit({required this.gpsCubit}) : super(MapInitial());

  final PopupController _popupLayerController = PopupController();
  final MapController _mapController = MapController();

  final defaultMapCenter = LatLng(50.02, 20.94);

  bool _permission = false;

  Future<void> initMap() async {
    final mapOptions = MapOptions(
      center: await _getMapCenter() ?? defaultMapCenter,
      zoom: 15.0,
      plugins: <MapPlugin>[LocationPlugin()],
      interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
      onTap: (_) => _popupLayerController.hidePopup(),
      maxZoom: 19,
    );
    List<Marker> markers = await getMarkers();
    List<LatLng> polypoints = await getPolylines();

    emit(MapLoaded(
        mapOptions: mapOptions,
        markers: markers,
        polypoints: polypoints,
        popupLayerController: _popupLayerController,
        mapController: _mapController,
        permission: _permission));
  }

  Future<LatLng?> _getMapCenter() async {
    if (await LocationController.canGetPosition()) {
      Geolocator.Position? position = await gpsCubit.getPosition();
      _permission = true;
      return LatLng(position!.latitude, position.longitude);
    }
    _permission = false;
    return null;
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
      busStopList.forEach((busStop) {
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
    initMap();
  }

  @override
  Future<List<Marker>> getMarkers() async {
    List<Marker> markers = List.empty(growable: true);
    await BusStopsDatabase.getBusStopsForTrack(track!.id).then((busStopList) {
      this.busStopList = busStopList;
      busStopList.forEach((busStop) {
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
    });
    return markers;
  }

  @override
  Future<List<LatLng>> getPolylines() async {
    List<LatLng> polypoints = List<LatLng>.empty(growable: true);
    for (int i = 0; i < busStopList.length - 1; i++) {
      String connectionString = await BusStopsConnectionDatabase.getConnection(
          busStopList[i], busStopList[i + 1]);
      List<String> trackPoints = connectionString.split(',');
      for (int j = 0; j < trackPoints.length; j += 2) {
        try {
          polypoints.add(LatLng(
              double.parse(trackPoints[j + 1].replaceAll(' ', '')),
              double.parse(trackPoints[j].replaceAll(' ', ''))));
        } catch (e) {}
      }
    }
    return polypoints;
  }
}
