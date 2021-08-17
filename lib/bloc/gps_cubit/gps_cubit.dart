import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_state.dart';

class GpsCubit extends Cubit<GpsState> {
  GpsCubit() : super(GpsInitial());

  Position? currentPosition;

  Future<void> initGps() async {
    Timer.periodic(new Duration(seconds: 2), (timer) {
      getPosition();
    });
  }

  Future<Position?> getPosition() async {
    if (await Geolocator.isLocationServiceEnabled()) {
      currentPosition = await Geolocator.getCurrentPosition();
    } else {
      currentPosition = await Geolocator.getLastKnownPosition();
    }
    return currentPosition;
  }
}
