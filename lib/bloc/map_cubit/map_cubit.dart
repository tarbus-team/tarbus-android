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
import 'package:tarbus_app/data/local/bus_stops_database.dart';
import 'package:tarbus_app/data/model/bus_stop_marker.dart';
import 'package:tarbus_app/shared/location_controller.dart';

part 'map_state.dart';

abstract class MapCubit extends Cubit<MapState> {
  final GpsCubit gpsCubit;

  MapCubit({required this.gpsCubit}) : super(MapInitial());

  final PopupController _popupLayerController = PopupController();
  final MapController _mapController = MapController();

  final tileLayerOptions = TileLayerWidget(
    options: TileLayerOptions(
      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      subdomains: ['a', 'b', 'c'],
    ),
  );

  final defaultMapCenter = LatLng(50.02, 20.94);

  bool _permission = false;

  Future<void> initMap() async {
    final mapOptions = MapOptions(
      center: await _getMapCenter() ?? defaultMapCenter,
      zoom: 13.0,
      plugins: <MapPlugin>[LocationPlugin()],
      interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
      onTap: (_) => _popupLayerController.hidePopup(),
      maxZoom: 17,
    );
    List<Marker> markers = await getMarkers();
    List<Widget> layers = [
      tileLayerOptions,
      PopupMarkerLayerWidget(
        options: PopupMarkerLayerOptions(
          popupController: _popupLayerController,
          markers: markers,
          markerRotateAlignment:
              PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
          popupBuilder: (BuildContext context, Marker marker) => Card(
            child: Text('dupa'),
          ),
        ),
      ),
    ];

    emit(MapLoaded(
        mapOptions: mapOptions,
        layers: layers,
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

  Future<List<Polyline>> getPolylines();
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
  Future<List<Polyline>> getPolylines() async {
    return List<Polyline>.empty(growable: true);
  }
}
