part of 'init_app_cubit.dart';

abstract class InitAppState extends Equatable {
  const InitAppState();

  @override
  List<Object> get props => [];
}

class InitStarted extends InitAppState {}

class InitLoading extends InitAppState {}

class InitAlert extends InitAppState {}

class DownloadingAppConfig extends InitAppState {}

class UpdatingSchedule extends InitAppState {}

class FirstAppRun extends InitAppState {}

class InitSuccess extends InitAppState {}

class InitFailure extends InitAppState {
  final String error;

  InitFailure({required this.error});

  @override
  List<Object> get props => [error];
}
