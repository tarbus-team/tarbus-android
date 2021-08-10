part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class AppLoading extends AppState {}

class AppLoaded extends AppState {
  final List<Map<String, dynamic>> data;

  AppLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class AppFailure extends AppState {
  final String error;

  AppFailure({required this.error});

  @override
  List<Object> get props => [error];
}
