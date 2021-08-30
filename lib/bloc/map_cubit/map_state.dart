part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final MapOptions mapOptions;
  final MapController mapController;
  final List<Marker> markers;
  final bool permission;
  final PopupController popupLayerController;
  final List<LatLng> polypoints;

  MapLoaded(
      {required this.permission,
      required this.popupLayerController,
      required this.markers,
      required this.polypoints,
      required this.mapOptions,
      required this.mapController});
}

class MapFailure extends MapState {
  final String error;

  MapFailure({required this.error});

  @override
  List<Object> get props => [error];
}
