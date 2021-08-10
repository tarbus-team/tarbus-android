import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';
import 'package:tarbus_app/data/storage/favourite_bus_stop_storage.dart';
import 'package:tarbus_app/data/storage_model/saved_bus_stop_model.dart';

part 'favourite_bus_stops_state.dart';

class FavouriteBusStopsCubit extends Cubit<FavouriteBusStopsState> {
  FavouriteBusStopsCubit() : super(FavouriteBusStopsInitial());

  Future<void> getFavourites() async {
    List<SavedBusStopModel> result = await FavouriteBusStopsStorage.getAll();
    emit(FavouriteBusStopsFound(busStops: result));
  }

  Future<void> addToFavourites(BusStop busStop, String name) async {
    await FavouriteBusStopsStorage.putNew(busStop, name);
    getFavourites();
  }
}
