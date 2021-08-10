import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/data/local/bus_stops_database.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';

part 'favourite_bus_lines_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> searchBusStops(String searchValue) async {
    List<BusStop> result =
        await BusStopsDatabase.getAllBusStops(name: searchValue);
    emit(SearchFoundBusStops(busStops: result));
  }
}
