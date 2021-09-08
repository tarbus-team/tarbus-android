import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tarbus_app/bloc/gps_cubit/gps_cubit.dart';
import 'package:tarbus_app/data/local/bus_stops_database.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';

part 'search_hint_state.dart';

class SearchHintCubit extends Cubit<SearchHintState> {
  final GpsCubit gpsCubit;

  SearchHintCubit({required this.gpsCubit}) : super(SearchHintInitial());

  Future<void> init() async {
    Timer.periodic(new Duration(seconds: 2), (timer) {
      search();
    });
    search();
  }

  Future<void> search() async {
    Position? position = gpsCubit.currentPosition;
    if (position == null) {
      print('BRAK GPS');
      return;
    }
    List<BusStop> nearestBusStops = await BusStopsDatabase.getAllBusStops();
    nearestBusStops.sort((a, b) {
      return (calcBusStopDestination(a, position)
          .compareTo(calcBusStopDestination(b, position)));
    });
    emit(SearchHintLoading());
    emit(SearchHintLoaded(nearestBusStops.sublist(0, 6)));
  }

  double calcBusStopDestination(BusStop a, Position b) {
    return sqrt(pow(a.lat! - b.latitude, 2) + pow(a.lng! - b.longitude, 2));
  }
}
