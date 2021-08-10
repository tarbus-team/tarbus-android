part of 'routes_cubit.dart';

abstract class RoutesState extends Equatable {
  const RoutesState();

  @override
  List<Object> get props => [];
}

class RoutesInitial extends RoutesState {}

class RoutesInProgress extends RoutesState {}

class RoutesLoaded extends RoutesState {
  final List<Map<String, dynamic>> data;

  RoutesLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class RoutesFailure extends RoutesState {
  final String error;

  RoutesFailure({required this.error});

  @override
  List<Object> get props => [error];
}
