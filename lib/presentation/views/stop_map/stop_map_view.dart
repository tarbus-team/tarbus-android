import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong/latlong.dart';
import 'package:tarbus2021/config/config.dart';
import 'package:tarbus2021/model/database/database_helper.dart';
import 'package:tarbus2021/model/entity/bus_stop_marker.dart';
import 'package:tarbus2021/presentation/custom_widgets/appbar_title.dart';
import 'package:tarbus2021/presentation/views/mini_schedule/mini_schedule_view.dart';

class StopMapView extends StatefulWidget {
  static const route = '/stopMap';

  const StopMapView({Key key}) : super(key: key);

  @override
  _StopMapViewState createState() => _StopMapViewState();
}

class _StopMapViewState extends State<StopMapView> {
  final PopupController _popupLayerController = PopupController();
  final MapController _mapController = MapController();
  final List<Marker> userLocationMarkers = <Marker>[];
  List<Marker> markers = <Marker>[];
  List<LatLng> polyPoints = <LatLng>[];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() {
    DatabaseHelper.instance.getAllBusStops().then((busStopList) async {
      busStopList.forEach((busStop) {
        markers.add(
          BusStopMarker(
            busStop: busStop,
            bwidth: 50.0,
            bheight: 50.0,
            bpoint: LatLng(busStop.lat, busStop.lng),
            bbuilder: (ctx) => Container(
              child: Image(image: AssetImage('assets/icons/bs-point-0.png')),
            ),
          ),
        );
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: AppBarTitle(
          title: 'Mapa przystanków',
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(53),
          child: Container(
            color: AppConfig.of(context).brandColors.primary,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 17),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Wszystkie przystanki',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          plugins: <MapPlugin>[PopupMarkerPlugin(), LocationPlugin()],
          center: AppConfig.of(context).centerMapCoords,
          interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          onTap: (_) => _popupLayerController.hidePopup(),
          zoom: 14.0,
          //minZoom: 10,
          maxZoom: 17,
        ),
        layers: [
          TileLayerOptions(
              backgroundColor: Colors.grey,
              //urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          PolylineLayerOptions(polylines: [
            Polyline(
              points: polyPoints,
              strokeWidth: 4,
              color: AppConfig.of(context).brandColors.primary,
            )
          ]),
          MarkerLayerOptions(markers: userLocationMarkers),
          PopupMarkerLayerOptions(
            markers: markers,
            popupSnap: PopupSnap.markerTop,
            popupController: _popupLayerController,
            popupBuilder: (context, marker) {
              if (marker is BusStopMarker) {
                return MiniScheduleView(busStop: marker.busStop);
              }
              return Card(child: const Text('Not found'));
            },
          ),
          LocationOptions(
            markers: userLocationMarkers,
            onLocationUpdate: (LatLngData ld) {
              // print('Location updated: ${ld?.location}');
            },
            onLocationRequested: (LatLngData ld) {
              if (ld == null || ld.location == null) {
                return;
              }
              _mapController?.move(ld.location, 14.0);
            },
            buttonBuilder: (BuildContext context, ValueNotifier<LocationServiceStatus> status, Function onPressed) {
              return Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
                  child: FloatingActionButton(
                      child: ValueListenableBuilder<LocationServiceStatus>(
                          valueListenable: status,
                          builder: (BuildContext context, LocationServiceStatus value, Widget child) {
                            switch (value) {
                              case LocationServiceStatus.disabled:
                              case LocationServiceStatus.permissionDenied:
                              case LocationServiceStatus.unsubscribed:
                                return const Icon(
                                  Icons.location_disabled,
                                  color: Colors.white,
                                );
                                break;
                              default:
                                return const Icon(
                                  Icons.location_searching,
                                  color: Colors.white,
                                );
                                break;
                            }
                          }),
                      onPressed: () => onPressed()),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
