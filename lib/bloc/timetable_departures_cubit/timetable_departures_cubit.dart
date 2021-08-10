import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/data/local/departures_database.dart';
import 'package:tarbus_app/data/local/routes_database.dart';
import 'package:tarbus_app/data/model/schedule/destination.dart';
import 'package:tarbus_app/data/model/schedule/track_route.dart';

part 'timetable_departures_state.dart';

class TimetableDeparturesCubit extends Cubit<TimetableDeparturesState> {
  TimetableDeparturesCubit() : super(TimetableInitial());

  Future<void> initTimetables(int busStopId) async {
    emit(TimetableLoading());
    Map<String, dynamic> finalResult = Map<String, dynamic>();
    List<String> daysAvailable = ['RO', 'WS', 'SW'];
    for (String day in daysAvailable) {
      List<Map<String, dynamic>> result = List.empty(growable: true);
      List<TrackRoute> routesFromStop =
          await RoutesDatabase.getAllFromBusStop(busStopId);
      for (TrackRoute route in routesFromStop) {
        Set<Destination> destinations = Set<Destination>();
        final departures = await DeparturesDatabase.getAllFromBusStopByDay(
          routeId: route.id,
          busStopId: busStopId,
          day: day,
        );
        destinations.addAll(departures.map((e) => e.destination).toList());

        result.add({
          'route': route,
          'departures': departures,
          'destinations': destinations
              .where((element) => _wantsToShowDestination(element))
              .toList(),
        });
      }
      finalResult[day] = result;
    }
    emit(TimetableLoaded(finalResult: finalResult));
  }

  bool _wantsToShowDestination(Destination destination) {
    if (destination.symbol.length != 1 || destination.symbol == '-') {
      return false;
    }
    return true;
  }
}
