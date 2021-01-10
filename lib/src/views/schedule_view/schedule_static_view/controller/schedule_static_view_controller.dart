import 'package:tarbus2021/src/database/database_helper.dart';
import 'package:tarbus2021/src/model/bus_line.dart';
import 'package:tarbus2021/src/model/departure.dart';
import 'package:tarbus2021/src/model/track.dart';
import 'package:tarbus2021/src/model/track_departure_holder.dart';

class ScheduleStaticViewController {
  static const String WorkDays = '1,3,4';
  static const String FreeDays = '2,4,8,9';
  static const String HolidayDays = '2,6,7';

  List<Departure> allDepartures = <Departure>[];
  List<BusLine> allBusLines = <BusLine>[];

  bool isRefreshing;

  ScheduleStaticViewController() {
    isRefreshing = true;
  }

  TrackDepartureHolder selectTracksAndDepartures(BusLine busLine) {
    List<Departure> selectedDepartures = <Departure>[];
    List<Track> tracks = <Track>[];

    for (var departure in allDepartures) {
      if (!isTrackInList(tracks, departure.track.destination.id) &&
          departure.busLine.id == busLine.id &&
          departure.track.destination.destinationShortcut != '-') {
        tracks.add(departure.track);
      }
      if (departure.busLine.id == busLine.id) {
        selectedDepartures.add(departure);
      }
    }
    return TrackDepartureHolder(tracks: tracks, selectedDepartures: selectedDepartures);
  }

  bool isInList(List<BusLine> list, int id) {
    for (var busLine in list) {
      if (busLine.id == id) {
        return true;
      }
    }
    return false;
  }

  bool isTrackInList(List<Track> list, int id) {
    for (var track in list) {
      if (track.destination.id == id) {
        return true;
      }
    }
    return false;
  }

  Future<List<Departure>> getAllDeparturesByDayType(int id, String dayTypes) async {
    allDepartures = await DatabaseHelper.instance.getAllDeparturesByDayType(id, dayTypes);
    for (var departure in allDepartures) {
      if (!isInList(allBusLines, departure.busLine.id)) {
        allBusLines.add(departure.busLine);
      }
    }
    return allDepartures;
  }
}
