import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/data/local/bus_lines_database.dart';
import 'package:tarbus_app/data/local/bus_stops_database.dart';
import 'package:tarbus_app/data/model/schedule/schedule_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  String lastSearchedValue = '';
  String lastSearchedType = '';

  Future<void> refresh() async {
    await search(lastSearchedValue, lastSearchedType, wantsRefresh: true);
    print('refresh');
  }

  Future<void> search(String searchValue, String type,
      {bool? wantsRefresh}) async {
    lastSearchedValue = searchValue;
    lastSearchedType = type;
    if (searchValue == '') {
      emit(SearchInitial());
      return;
    }
    List<ScheduleModel> result = List.empty(growable: true);
    switch (type) {
      case 'bus_stop':
        result = await BusStopsDatabase.getAllBusStops(name: searchValue);
        break;
      case 'bus_line':
        result = await BusLinesDatabase.getAllBusLines(name: searchValue);
        break;
      case 'mix':
        List<ScheduleModel> resultOne =
            await BusStopsDatabase.getAllBusStops(name: searchValue);
        List<ScheduleModel> resultTwo =
            await BusLinesDatabase.getAllBusLines(name: searchValue);
        result.addAll(resultOne);
        result.addAll(resultTwo);
        result.shuffle();
        break;
      default:
        result = List.empty(growable: true);
    }
    emit(SearchLoading());
    emit(SearchFound(result: result));
    if (wantsRefresh != null && wantsRefresh) {
      emit(SearchRefresh());
      emit(SearchFound(result: result));
    }
  }
}
