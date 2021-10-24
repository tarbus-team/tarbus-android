import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/config/locator.dart';
import 'package:tarbus_app/data/local/bus_lines_database.dart';
import 'package:tarbus_app/data/local/calendar_database.dart';
import 'package:tarbus_app/data/local/departures_database.dart';
import 'package:tarbus_app/data/model/departure_wrapper.dart';
import 'package:tarbus_app/data/model/remote_departure.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';
import 'package:tarbus_app/data/model/schedule/calendar.dart';
import 'package:tarbus_app/data/model/schedule/departure.dart';
import 'package:tarbus_app/data/remote/mpk_repository.dart';
import 'package:tarbus_app/data/storage_model/subscribed_version_model.dart';
import 'package:tarbus_app/data/subscribed_schedule_storage.dart';
import 'package:tarbus_app/shared/utilities/date_time_utils.dart';

part 'departures_state.dart';

class DeparturesCubit extends Cubit<DeparturesState> {
  DeparturesCubit() : super(DeparturesInitial());

  List<BusLine> busLinesFromBusStop = List.empty(growable: true);
  List<DepartureWrapper> allDepartures = List.empty(growable: true);
  List<RemoteDeparture> remoteDepartures = List.empty(growable: true);
  List<BusLine> busLineFilters = List.empty(growable: true);
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
    busLinesFromBusStop = List.empty(growable: true);
    allDepartures = List.empty(growable: true);
    remoteDepartures = List.empty(growable: true);
    daysAhead = 0;
  }

  bool _wantsRemoteDepartures() {
    final localVersions = SubscribedScheduleStorage.getSubscribedVersions();
    for (SubscribedVersionModel version in localVersions) {
      if (version.subscribeCode == "mpktarnow") {
        return true;
      }
    }
    return false;
  }

  Future<void> getAll({required int busStopId}) async {
    DateTime departuresDate = DateTime.now().add(Duration(days: daysAhead));
    if (daysAhead == 0) {
      if (_wantsRemoteDepartures()) {
        remoteDepartures =
            await getIt<RemoteMpkRepository>().getLiveDepartures(busStopId);
      }
      busLinesFromBusStop = await BusLinesDatabase.getAllFromBusStop(busStopId);
    }

    final departures = await fetchDatabaseDepartures(busStopId);
    for (int i = 0; i < departures.length; i++) {
      var departure = departures[i];
      var matchesRemotes = daysAhead == 0 && remoteDepartures.isNotEmpty
          ? remoteDepartures
              .where((e) => (e.trackId == departure.track.id))
              .toList()
          : List.empty();
      RemoteDeparture? matchedRemoteDeparture =
          matchesRemotes.isNotEmpty ? matchesRemotes.first : null;
      allDepartures.add(
        DepartureWrapper(
          departure: departure,
          isOnline: matchedRemoteDeparture != null,
          remoteDeparture: matchedRemoteDeparture,
          daysAhead: daysAhead,
          departureDate: departuresDate,
          isBreakpoint: i == departures.length - 1,
        ),
      );
    }
    daysAhead += 1;
    if (allDepartures.length < 50) {
      await getAll(busStopId: busStopId);
    } else {
      emit(DeparturesLoading());
      emit(DeparturesLoaded(
        lineFilters: busLineFilters,
        departures: allDepartures,
        busLinesFromBusStop: busLinesFromBusStop.toList(),
      ));
    }
  }

  Future<List<Departure>> fetchDatabaseDepartures(int busStopId) async {
    List<String> dayTypes = await getDayTypes();
    int currentTimeInMinutes =
        daysAhead == 0 ? DateTimeUtils.getCurrentTimeInMinutes() : 60;
    return await DeparturesDatabase.getNextFromBusStop(
      busStopId: busStopId,
      timeInMin: currentTimeInMinutes,
      dayTypes: dayTypes,
      busLinesId: busLineFilters.map((e) => e.id).toList(),
    );
  }

  Future<List<String>> getDayTypes() async {
    String timestamp =
        DateTimeUtils.getDate("dd-MM-yyyy", daysAhead: daysAhead);

    List<String> dayTypes = _getDayTypesFromCalendarList(
        await CalendarDatabase.getCurrentDays(timestamp));
    return dayTypes;
  }

  Future<void> setFilters(int busStopId, List<BusLine> busLines) async {
    initDepartures();
    busLineFilters = busLines;
    // getAll(busStopId: busStopId);
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
