part of 'departures_mini_cubit.dart';

abstract class DeparturesMiniState extends Equatable {
  const DeparturesMiniState();

  @override
  List<Object> get props => [];
}

class DeparturesMiniInitial extends DeparturesMiniState {}

class DeparturesMiniLoading extends DeparturesMiniState {}

class DeparturesMiniLoaded extends DeparturesMiniState {
  final List<Departure> departures;
  final int? breakpoint;

  DeparturesMiniLoaded({
    required this.departures,
    this.breakpoint,
  });

  @override
  List<Object> get props => [departures];
}

class DeparturesMiniEmpty extends DeparturesMiniState {}

class DeparturesMiniFailure extends DeparturesMiniState {
  final String error;

  DeparturesMiniFailure({required this.error});

  @override
  List<Object> get props => [error];
}
