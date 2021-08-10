import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/data/local/calendar_database.dart';
import 'package:tarbus_app/data/local/departures_database.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';
import 'package:tarbus_app/data/model/schedule/calendar.dart';
import 'package:tarbus_app/data/model/schedule/departure.dart';
import 'package:tarbus_app/shared/utilities/date_time_utils.dart';

part 'departures_state.dart';

class DeparturesCubit extends Cubit<DeparturesState> {
  DeparturesCubit() : super(DeparturesInitial());

  Set<BusLine> busLinesFromBusStop = Set<BusLine>();
  List<Departure> allDepartures = List.empty(growable: true);
  List<BusLine> busLineFilters = List.empty(growable: true);
  List<int> daysAheadList = List.empty(growable: true);
  int daysAhead = 0;

  void initNewView({List<BusLine>? initialFilters, BusLine? initialFilter}) {
    emit(DeparturesLoading());
    initDepartures(
        initialFilters: initialFilters, initialFilter: initialFilter);
  }

  void initDepartures({List<BusLine>? initialFilters, BusLine? initialFilter}) {
    if (initialFilters != null) {
      busLineFilters = initialFilters;
    } else {
      busLineFilters = List.empty(growable: true);
    }
    if (initialFilter != null) {
      busLineFilters.add(initialFilter);
    }
    busLinesFromBusStop = Set<BusLine>();
    allDepartures = List.empty(growable: true);
    daysAheadList = List.empty(growable: true);
    daysAhead = 0;
  }

  Future<void> getAll({required int busStopId}) async {
    String timestamp =
        DateTimeUtils.getDate("dd-MM-yyyy", daysAhead: daysAhead);
    int currentTimeInMinutes = DateTimeUtils.getCurrentTimeInMinutes();
    if (daysAhead != 0) {
      currentTimeInMinutes = 60;
    }
    List<String> dayTypes = _getDayTypesFromCalendarList(
        await CalendarDatabase.getCurrentDays(timestamp));
    final departures = await DeparturesDatabase.getNextFromBusStop(
      busStopId: busStopId,
      timeInMin: currentTimeInMinutes,
      dayTypes: dayTypes,
      busLinesId: busLineFilters.map((e) => e.id).toList(),
    );
    allDepartures.addAll(departures);
    busLinesFromBusStop.addAll(departures.map((d) => d.track.route.busLine));

    daysAheadList.addAll(
      List.generate(departures.length, (index) => daysAhead),
    );
    daysAhead += 1;
    await Future.delayed(Duration(milliseconds: 150));
    emit(DeparturesLoading());
    emit(DeparturesLoaded(
      daysAhead: daysAheadList,
      lineFilters: busLineFilters,
      departures: allDepartures,
      busLinesFromBusStop: busLinesFromBusStop.toList(),
    ));
    if (allDepartures.length < 20) {
      getAll(busStopId: busStopId);
    }
  }

  Future<void> setFilters(int busStopId, List<BusLine> busLines) async {
    initDepartures();
    busLineFilters = busLines;
    getAll(busStopId: busStopId);
  }

  Future<void> deleteFilter(
      {required int busStopId, required BusLine busLine}) async {
    initDepartures(initialFilters: busLineFilters);
    busLineFilters.remove(busLine);
    getAll(busStopId: busStopId);
  }

  List<String> _getDayTypesFromCalendarList(List<Calendar> calendars) {
    Set<String> dayTypes = Set<String>();
    print(calendars);
    for (Calendar calendar in calendars) {
      dayTypes.addAll(calendar.dayTypes.split(' '));
    }
    print(dayTypes);
    return dayTypes.toList();
  }
}
