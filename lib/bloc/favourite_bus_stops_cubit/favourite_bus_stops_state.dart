part of 'favourite_bus_stops_cubit.dart';

abstract class FavouriteBusStopsState extends Equatable {
  const FavouriteBusStopsState();

  @override
  List<Object> get props => [];
}

class FavouriteBusStopsInitial extends FavouriteBusStopsState {}

class FavouriteBusStopsInProgress extends FavouriteBusStopsState {}

class FavouriteBusStopsFound extends FavouriteBusStopsState {
  final List<SavedBusStopModel> busStops;

  FavouriteBusStopsFound({required this.busStops});

  @override
  List<Object> get props => [busStops];
}

class FavouriteBusStopsFailure extends FavouriteBusStopsState {
  final String error;

  FavouriteBusStopsFailure({required this.error});

  @override
  List<Object> get props => [error];
}
