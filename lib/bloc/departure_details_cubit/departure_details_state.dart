part of 'departure_details_cubit.dart';

abstract class DepartureDetailsState extends Equatable {
  const DepartureDetailsState();

  @override
  List<Object> get props => [];
}

class DepartureDetailsInitial extends DepartureDetailsState {}

class DepartureDetailsProgress extends DepartureDetailsState {}

class DepartureDetailsLoaded extends DepartureDetailsState {
  final List<Departure> departures;

  DepartureDetailsLoaded({required this.departures});

  @override
  List<Object> get props => [departures];
}

class DepartureDetailsFailure extends DepartureDetailsState {
  final String error;

  DepartureDetailsFailure({required this.error});

  @override
  List<Object> get props => [error];
}
