part of 'timetable_departures_cubit.dart';

abstract class TimetableDeparturesState extends Equatable {
  const TimetableDeparturesState();

  @override
  List<Object> get props => [];
}

class TimetableInitial extends TimetableDeparturesState {}

class TimetableLoading extends TimetableDeparturesState {}

class TimetableLoaded extends TimetableDeparturesState {
  final Map<String, dynamic> finalResult;

  TimetableLoaded({required this.finalResult});

  @override
  List<Object> get props => [finalResult];
}

class TimetableFailure extends TimetableDeparturesState {
  final String error;

  TimetableFailure({required this.error});

  @override
  List<Object> get props => [error];
}
