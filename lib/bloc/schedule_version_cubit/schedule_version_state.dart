part of 'schedule_version_cubit.dart';

abstract class ScheduleVersionState extends Equatable {
  const ScheduleVersionState();

  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleVersionState {}

class ScheduleEmpty extends ScheduleVersionState {}

class ScheduleRemoved extends ScheduleVersionState {}

class ScheduleChecking extends ScheduleVersionState {}

class ScheduleUpToDate extends ScheduleVersionState {}

class ScheduleOutOfDate extends ScheduleVersionState {}

class ScheduleCheckingFinished extends ScheduleVersionState {}

class ScheduleDownloading extends ScheduleVersionState {
  final int count;
  final int? total;

  ScheduleDownloading({required this.count, this.total});
}

class ScheduleFailure extends ScheduleVersionState {
  final String error;

  ScheduleFailure({required this.error});

  @override
  List<Object> get props => [error];
}
