part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchInProgress extends SearchState {}

class SearchFoundBusStops extends SearchState {
  final List<BusStop> busStops;

  SearchFoundBusStops({required this.busStops});

  @override
  List<Object> get props => [busStops];
}

class SearchFoundBusLines extends SearchState {}

class SearchFailure extends SearchState {
  final String error;

  SearchFailure({required this.error});

  @override
  List<Object> get props => [error];
}
