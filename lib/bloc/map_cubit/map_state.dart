part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final LatLng mapCenter;
  final List<Marker> markers;
  final bool permission;
  final double zoom;
  final List<LatLng> polypoints;

  MapLoaded({
    required this.permission,
    required this.markers,
    required this.zoom,
    required this.polypoints,
    required this.mapCenter,
  });
}

class MapFailure extends MapState {
  final String error;

  MapFailure({required this.error});

  @override
  List<Object> get props => [error];
}
