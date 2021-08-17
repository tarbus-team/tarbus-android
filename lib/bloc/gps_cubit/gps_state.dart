part of 'gps_cubit.dart';

abstract class GpsState extends Equatable {
  const GpsState();

  @override
  List<Object> get props => [];
}

class GpsInitial extends GpsState {}

class GpsLoading extends GpsState {}

class GpsLoaded extends GpsState {
  final List<Map<String, dynamic>> data;

  GpsLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class GpsFailure extends GpsState {
  final String error;

  GpsFailure({required this.error});

  @override
  List<Object> get props => [error];
}
