import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:tarbus_app/bloc/map_cubit/map_cubit.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/bus_stop_marker.dart';
import 'package:tarbus_app/views/widgets/generic/center_load_spinner.dart';

import 'mini_schedule_view.dart';

class MapWidget<T extends MapCubit> extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapWidget<T>();
}

class _MapWidget<T extends MapCubit> extends State<MapWidget<T>> {
  @override
  void initState() {
    context.read<T>().initMap();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, MapState>(
      builder: (context, state) {
        if (state is MapLoaded) {
          return FlutterMap(
            mapController: state.mapController,
            options: state.mapOptions,
            children: [
              TileLayerWidget(
                options: TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
              ),
              PolylineLayerWidget(
                options: PolylineLayerOptions(polylines: [
                  Polyline(
                    points: state.polypoints,
                    strokeWidth: 4,
                    color: AppColors.of(context).primaryColor,
                  )
                ]),
              ),
              PopupMarkerLayerWidget(
                options: PopupMarkerLayerOptions(
                  popupController: state.popupLayerController,
                  markers: state.markers,
                  popupBuilder: (BuildContext context, Marker marker) {
                    if (marker is BusStopMarker) {
                      return MiniScheduleView(
                        busStop: marker.busStop,
                      );
                    }
                    return Text('');
                  },
                ),
              ),
            ],
            layers: [
              LocationOptions(
                locationButton(state),
                markerBuilder: (BuildContext context, LatLngData ld,
                    ValueNotifier<double?> heading) {
                  return Marker(
                    builder: (BuildContext context) {
                      return Text('');
                    },
                    point: ld.location,
                  );
                },
                onLocationRequested: (LatLngData? ld) {
                  if (ld == null) {
                    return;
                  }
                  state.mapController.move(ld.location, 14.0);
                },
              ),
            ],
          );
        }
        return CenterLoadSpinner();
      },
    );
  }

  LocationButtonBuilder locationButton(MapState state) {
    return (BuildContext context, ValueNotifier<LocationServiceStatus> status,
        Function onPressed) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
          child: FloatingActionButton(
              backgroundColor: AppColors.of(context).primaryColor,
              child: ValueListenableBuilder<LocationServiceStatus>(
                  valueListenable: status,
                  builder: (BuildContext context, LocationServiceStatus value,
                      Widget? child) {
                    switch (value) {
                      case LocationServiceStatus.disabled:
                      case LocationServiceStatus.permissionDenied:
                      case LocationServiceStatus.unsubscribed:
                        return const Icon(
                          Icons.location_disabled,
                          color: Colors.white,
                        );
                      default:
                        return const Icon(
                          Icons.location_searching,
                          color: Colors.white,
                        );
                    }
                  }),
              onPressed: () => onPressed()),
        ),
      );
    };
  }
}
