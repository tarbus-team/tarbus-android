import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/data/local/calendar_database.dart';
import 'package:tarbus_app/data/local/departures_database.dart';
import 'package:tarbus_app/data/model/schedule/calendar.dart';
import 'package:tarbus_app/data/model/schedule/departure.dart';
import 'package:tarbus_app/shared/utilities/date_time_utils.dart';

part 'departures_mini_state.dart';

class DeparturesMiniCubit extends Cubit<DeparturesMiniState> {
  DeparturesMiniCubit() : super(DeparturesMiniInitial());

  Future<void> initDepartures({required int busStopId}) async {
    emit(DeparturesMiniLoading());
    String timestamp = DateTimeUtils.getDate("dd-MM-yyyy", daysAhead: 0);
    int currentTimeInMinutes = DateTimeUtils.getCurrentTimeInMinutes();
    List<String> dayTypes = _getDayTypesFromCalendarList(
        await CalendarDatabase.getCurrentDays(timestamp));
    final departures = await DeparturesDatabase.getNextFromBusStop(
      busStopId: busStopId,
      timeInMin: currentTimeInMinutes,
      dayTypes: dayTypes,
      limit: 6,
    );
    int? breakpoint;
    if (departures.length < 6) {
      breakpoint = departures.length;
      String timestamp = DateTimeUtils.getDate("dd-MM-yyyy", daysAhead: 1);
      dayTypes = _getDayTypesFromCalendarList(
          await CalendarDatabase.getCurrentDays(timestamp));
      departures.addAll(await DeparturesDatabase.getNextFromBusStop(
        busStopId: busStopId,
        timeInMin: 70,
        dayTypes: dayTypes,
        limit: 6 - departures.length,
      ));
    }

    emit(DeparturesMiniLoaded(
      departures: departures,
      breakpoint: breakpoint,
    ));
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
