part of 'departures_cubit.dart';

abstract class DeparturesState extends Equatable {
  const DeparturesState();

  @override
  List<Object> get props => [];
}

class DeparturesInitial extends DeparturesState {}

class DeparturesLoading extends DeparturesState {}

class DeparturesLoaded extends DeparturesState {
  final List<DepartureWrapper> departures;
  final List<BusLine> busLinesFromBusStop;
  final List<BusLine> lineFilters;

  DeparturesLoaded({
    required this.departures,
    required this.lineFilters,
    required this.busLinesFromBusStop,
  });

  @override
  List<Object> get props => [departures];
}

class DeparturesEmpty extends DeparturesState {}

class DeparturesFailure extends DeparturesState {
  final String error;

  DeparturesFailure({required this.error});

  @override
  List<Object> get props => [error];
}
