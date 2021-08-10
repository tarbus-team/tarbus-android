import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

enum AppNetworkStatus { WAITING, ONLINE, OFFLINE }

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  AppNetworkStatus appNetworkStatus = AppNetworkStatus.WAITING;

  Future<void> initApp(AppNetworkStatus networkStatus) async {
    appNetworkStatus = networkStatus;
  }
}
