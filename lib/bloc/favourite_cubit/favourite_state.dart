part of 'favourite_cubit.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteBusStopLoaded extends FavouriteState {
  final List<SavedBusStopModel> busStops;

  FavouriteBusStopLoaded({required this.busStops});
}

class FavouriteBusLinesLoaded extends FavouriteState {
  final List<SavedBusLineModel> busLines;

  FavouriteBusLinesLoaded({required this.busLines});
}

class FavouriteFailure extends FavouriteState {
  final String error;

  FavouriteFailure({required this.error});

  @override
  List<Object> get props => [error];
}
