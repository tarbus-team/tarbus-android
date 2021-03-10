import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong/latlong.dart';
import 'package:tarbus2021/config/config.dart';
import 'package:tarbus2021/model/database/database_helper.dart';
import 'package:tarbus2021/model/entity/bus_stop_marker.dart';
import 'package:tarbus2021/model/entity/departure.dart';
import 'package:tarbus2021/model/entity/track.dart';
import 'package:tarbus2021/presentation/custom_widgets/appbar_title.dart';
import 'package:tarbus2021/presentation/views/mini_schedule/mini_schedule_view.dart';

class BusMapView extends StatefulWidget {
  static const route = '/map';
  final Track track;

  const BusMapView({Key key, this.track}) : super(key: key);

  @override
  _BusMapViewState createState() => _BusMapViewState();
}

class _BusMapViewState extends State<BusMapView> {
  final PopupController _popupLayerController = PopupController();
  final MapController _mapController = MapController();
  final List<Marker> userLocationMarkers = <Marker>[];
  bool isFirstLocationRequest = true;
  List<Marker> markers = <Marker>[];
  List<LatLng> polyPoints = <LatLng>[];
  Track track;

  @override
  void initState() {
    track = widget.track;
    fetchData();
    super.initState();
  }

  void fetchData() {
    DatabaseHelper.instance.getDeparturesByTrackId(track.id).then((departureList) async {
      departureList.forEach((departure) {
        markers.add(
          BusStopMarker(
            busStop: departure.busStop,
            bwidth: 50.0,
            bheight: 50.0,
            bpoint: LatLng(departure.busStop.lat, departure.busStop.lng),
            bbuilder: (ctx) => Container(
              child: Image(image: AssetImage('assets/icons/bs-point-0.png')),
            ),
          ),
        );
      });
      await getTrackList(departureList);
    });
  }

  Future<void> getTrackList(List<Departure> departureList) async {
    for (int i = 0; i < (departureList.length - 1); i++) {
      await DatabaseHelper.instance
          .getTrackCoords(departureList[i].busStop.id, departureList[i + 1].busStop.id)
          .then((coordsString) {
        List<String> unparsed = coordsString.split(',');
        for (int i = 0; i < unparsed.length; i += 2) {
          polyPoints.add(LatLng(double.parse(unparsed[i + 1]), double.parse(unparsed[i])));
        }
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: AppBarTitle(
          title: 'Kurs',
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(53),
          child: Container(
            color: AppConfig.of(context).brandColors.primary,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 17),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(track.route.busLine.name,
                          style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'kierunek:',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              track.destination.directionBoardName,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
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
          zoom: 13.0,
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
                return Wrap(
                  direction: Axis.vertical,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Card(
                        child: Wrap(
                          children: [
                            MiniScheduleView(busStop: marker.busStop),
                          ],
                        ),
                      ),
                    ),
                    Image(
                      image: AssetImage('assets/icons/down-arrow.png'),
                    )
                  ],
                );
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
              if (isFirstLocationRequest) {
                isFirstLocationRequest = false;
              } else {
                _mapController?.move(ld.location, 13.0);
              }
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
