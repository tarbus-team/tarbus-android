part of 'first_config_cubit.dart';

abstract class FirstConfigState extends Equatable {
  const FirstConfigState();

  @override
  List<Object> get props => [];
}

class FirstConfigLoading extends FirstConfigState {}

class FirstConfigDownloading extends FirstConfigState {}

class FirstConfigLoaded extends FirstConfigState {
  final AvailableVersionsResponse availableVersionsResponse;

  FirstConfigLoaded({required this.availableVersionsResponse});

  @override
  List<Object> get props => [availableVersionsResponse];
}

class FirstConfigFailure extends FirstConfigState {
  final String error;

  FirstConfigFailure({required this.error});

  @override
  List<Object> get props => [error];
}
