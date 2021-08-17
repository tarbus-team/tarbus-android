part of 'search_hint_cubit.dart';

abstract class SearchHintState extends Equatable {
  const SearchHintState();

  @override
  List<Object> get props => [];
}

class SearchHintInitial extends SearchHintState {}

class SearchHintLoading extends SearchHintState {}

class SearchHintLoaded extends SearchHintState {
  final List<BusStop> stops;

  SearchHintLoaded(this.stops);
}

class SearchHintFailure extends SearchHintState {
  final String error;

  SearchHintFailure({required this.error});

  @override
  List<Object> get props => [error];
}
