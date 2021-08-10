import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/data/local/bus_stops_database.dart';
import 'package:tarbus_app/data/local/routes_database.dart';
import 'package:tarbus_app/data/model/schedule/track_route.dart';

part 'routes_state.dart';

class RoutesCubit extends Cubit<RoutesState> {
  RoutesCubit() : super(RoutesInitial());

  Future<void> getAllByLine(int busLineId) async {
    List<Map<String, dynamic>> result = List.empty(growable: true);
    List<TrackRoute> routesList =
        await RoutesDatabase.getRoutesForBusLine(busLineId);
    for (TrackRoute route in routesList) {
      result.add({
        "route": route,
        "bus_stops": await BusStopsDatabase.getBusStopsForRoute(route.id),
      });
    }
    emit(RoutesLoaded(data: result));
  }
}
