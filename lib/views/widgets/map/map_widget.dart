import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:tarbus_app/bloc/gps_cubit/gps_cubit.dart';
import 'package:tarbus_app/bloc/map_cubit/map_cubit.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/config/app_config.dart';
import 'package:tarbus_app/data/model/bus_stop_marker.dart';
import 'package:tarbus_app/views/widgets/generic/center_load_spinner.dart';

import 'mini_schedule_view.dart';

class MapWidget<T extends MapCubit> extends StatefulWidget {
  final bool wantsMarkerCluster;

  const MapWidget({
    Key? key,
    this.wantsMarkerCluster = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapWidget<T>();
}

class _MapWidget<T extends MapCubit> extends State<MapWidget<T>> {
  MapController mapController = MapController();
  PopupController popupController = PopupController();

  int locationRequestCounter = 0;

  @override
  void initState() {
    context.read<T>().initMap(mapController, popupController);
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
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.of(context).primaryColor,
              child: Icon(
                Icons.location_searching,
                color: Colors.white,
              ),
              onPressed: () {
                Position? position = context.read<GpsCubit>().currentPosition;
                if (position != null)
                  mapController.move(
                      LatLng(position.latitude, position.longitude), 14);
              },
            ),
            body: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: state.mapCenter,
                zoom: state.zoom,
                interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                onTap: (tapPosition, latlng) => popupController.hideAllPopups(),
                maxZoom: 18,
                plugins: [
                  MarkerClusterPlugin(),
                ],
              ),
              children: [
                TileLayerWidget(
                  options: TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    tilesContainerBuilder:
                        context.read<GetAppConfigUseCaseImpl>().isDarkTheme
                            ? darkModeTilesContainerBuilder
                            : null,
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
                LocationMarkerLayerWidget(),
                if (widget.wantsMarkerCluster)
                  MarkerClusterLayerWidget(
                    options: MarkerClusterLayerOptions(
                      maxClusterRadius: 120,
                      disableClusteringAtZoom: 15,
                      size: Size(40, 40),
                      fitBoundsOptions: FitBoundsOptions(
                        padding: EdgeInsets.all(50),
                      ),
                      markers: state.markers
                          .where((e) => e is BusStopMarker)
                          .toList(),
                      builder: (context, markers) {
                        return FloatingActionButton(
                          backgroundColor: AppColors.of(context).primaryColor,
                          child: Text(markers.length.toString()),
                          onPressed: null,
                        );
                      },
                      polygonOptions: PolygonOptions(
                          borderColor: Colors.transparent,
                          color: Colors.transparent,
                          borderStrokeWidth: 0),
                      popupOptions: PopupOptions(
                        popupController: popupController,
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
                  ),
                PopupMarkerLayerWidget(
                  options: PopupMarkerLayerOptions(
                    popupController: popupController,
                    markers: widget.wantsMarkerCluster
                        ? state.markers
                            .where((e) => !(e is BusStopMarker))
                            .toList()
                        : state.markers,
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
            ),
          );
        }
        return CenterLoadSpinner();
      },
    );
  }

//   LocationButtonBuilder locationButton(MapState state) {
//     return (BuildContext context, ValueNotifier<LocationServiceStatus> status,
//         Function onPressed) {
//       return Align(
//         alignment: Alignment.bottomRight,
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
//           child: FloatingActionButton(
//               backgroundColor: AppColors.of(context).primaryColor,
//               child: ValueListenableBuilder<LocationServiceStatus>(
//                   valueListenable: status,
//                   builder: (BuildContext context, LocationServiceStatus value,
//                       Widget? child) {
//                     switch (value) {
//                       case LocationServiceStatus.disabled:
//                       case LocationServiceStatus.permissionDenied:
//                       case LocationServiceStatus.unsubscribed:
//                         return const Icon(
//                           Icons.location_disabled,
//                           color: Colors.white,
//                         );
//                       default:
//                         return const Icon(
//                           Icons.location_searching,
//                           color: Colors.white,
//                         );
//                     }
//                   }),
//               onPressed: () => onPressed()),
//         ),
//       );
//     };
//   }
}
