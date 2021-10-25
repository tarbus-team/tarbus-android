import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/config/locator.dart';
import 'package:tarbus_app/data/local/calendar_database.dart';
import 'package:tarbus_app/data/local/departures_database.dart';
import 'package:tarbus_app/data/model/departure_wrapper.dart';
import 'package:tarbus_app/data/model/remote_departure.dart';
import 'package:tarbus_app/data/model/schedule/calendar.dart';
import 'package:tarbus_app/data/model/schedule/departure.dart';
import 'package:tarbus_app/data/remote/mpk_repository.dart';
import 'package:tarbus_app/data/storage_model/subscribed_version_model.dart';
import 'package:tarbus_app/data/subscribed_schedule_storage.dart';
import 'package:tarbus_app/shared/utilities/date_time_utils.dart';

part 'departures_mini_state.dart';

class DeparturesMiniCubit extends Cubit<DeparturesMiniState> {
  DeparturesMiniCubit() : super(DeparturesMiniInitial());

  Future<void> initDepartures({required int busStopId}) async {
    emit(DeparturesMiniLoading());
    List<DepartureWrapper> resultDepartures = List.empty(growable: true);
    List<RemoteDeparture> remoteDepartures = List.empty(growable: true);

    try {
      if (_wantsRemoteDepartures()) {
        remoteDepartures =
            await getIt<RemoteMpkRepository>().getLiveDepartures(busStopId);
      }
    } on Exception {
      remoteDepartures = List.empty(growable: true);
    }

    int daysAhead = 0;
    while (resultDepartures.length < 6) {
      final departures = await _fetchDatabaseDepartures(daysAhead, busStopId);
      final departuresDate = DateTime.now().add(Duration(days: daysAhead));
      for (int i = 0; i < departures.length; i++) {
        var departure = departures[i];
        var matchesRemotes = daysAhead == 0 && remoteDepartures.isNotEmpty
            ? remoteDepartures
                .where((e) => (e.trackId == departure.track.id))
                .toList()
            : List.empty();
        RemoteDeparture? matchedRemoteDeparture =
            matchesRemotes.isNotEmpty ? matchesRemotes.first : null;
        resultDepartures.add(
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
    }

    emit(DeparturesMiniLoaded(
      departures: resultDepartures,
    ));
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

  Future<List<String>> _getDayTypes(int daysAhead) async {
    String timestamp =
        DateTimeUtils.getDate("dd-MM-yyyy", daysAhead: daysAhead);

    List<String> dayTypes = _getDayTypesFromCalendarList(
        await CalendarDatabase.getCurrentDays(timestamp));
    return dayTypes;
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

  Future<List<Departure>> _fetchDatabaseDepartures(
      int daysAhead, int busStopId) async {
    List<String> dayTypes = await _getDayTypes(daysAhead);
    int currentTimeInMinutes =
        daysAhead == 0 ? DateTimeUtils.getCurrentTimeInMinutes() : 60;
    return await DeparturesDatabase.getNextFromBusStop(
      busStopId: busStopId,
      timeInMin: currentTimeInMinutes,
      dayTypes: dayTypes,
      limit: 6,
    );
  }
}
