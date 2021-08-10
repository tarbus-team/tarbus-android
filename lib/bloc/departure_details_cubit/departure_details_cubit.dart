import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/data/local/departures_database.dart';
import 'package:tarbus_app/data/model/schedule/departure.dart';

part 'departure_details_state.dart';

class DepartureDetailsCubit extends Cubit<DepartureDetailsState> {
  DepartureDetailsCubit() : super(DepartureDetailsInitial());

  Future<void> getTrackDepartures(Departure departure) async {
    List<Departure> departures = await DeparturesDatabase.getTrackDepartures(
        trackId: departure.track.id);
    emit(DepartureDetailsLoaded(departures: departures));
  }
}
