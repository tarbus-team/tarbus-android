part of 'bus_lines_cubit.dart';

abstract class BusLinesState extends Equatable {
  const BusLinesState();

  @override
  List<Object> get props => [];
}

class BusLinesInitial extends BusLinesState {}

class BusLinesInProgress extends BusLinesState {}

class BusLinesLoaded extends BusLinesState {
  final List<Map<String, dynamic>> data;

  BusLinesLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class BusLinesFailure extends BusLinesState {
  final String error;

  BusLinesFailure({required this.error});

  @override
  List<Object> get props => [error];
}
