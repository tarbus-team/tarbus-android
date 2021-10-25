part of 'departures_mini_cubit.dart';

abstract class DeparturesMiniState extends Equatable {
  const DeparturesMiniState();

  @override
  List<Object> get props => [];
}

class DeparturesMiniInitial extends DeparturesMiniState {}

class DeparturesMiniLoading extends DeparturesMiniState {}

class DeparturesMiniLoaded extends DeparturesMiniState {
  final List<DepartureWrapper> departures;

  DeparturesMiniLoaded({
    required this.departures,
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
