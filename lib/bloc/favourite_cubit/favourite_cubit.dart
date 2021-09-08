import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/data/storage/favourite_bus_lines_storage.dart';
import 'package:tarbus_app/data/storage/favourite_bus_stop_storage.dart';
import 'package:tarbus_app/data/storage_model/saved_bus_line_model.dart';
import 'package:tarbus_app/data/storage_model/saved_bus_stop_model.dart';

part 'favourite_state.dart';

abstract class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  Future<void> getFavourites();

  Future<void> addToFavourites(dynamic item);
}

class FavouriteBusStopsCubit extends FavouriteCubit {
  @override
  Future<void> getFavourites() async {
    List<SavedBusStopModel> result = await FavouriteBusStopsStorage.getAll();
    emit(FavouriteLoading());
    emit(FavouriteBusStopLoaded(busStops: result));
  }

  @override
  Future<void> addToFavourites(dynamic item) async {
    SavedBusStopModel busStop = item as SavedBusStopModel;
    await FavouriteBusStopsStorage.putNew(busStop);
    getFavourites();
  }
}

class FavouriteBusLinesCubit extends FavouriteCubit {
  @override
  Future<void> getFavourites() async {
    List<SavedBusLineModel> result = await FavouriteBusLinesStorage.getAll();
    print(result);
    emit(FavouriteLoading());
    emit(FavouriteBusLinesLoaded(busLines: result));
  }

  @override
  Future<void> addToFavourites(dynamic item) async {
    SavedBusLineModel busLine = item as SavedBusLineModel;
    await FavouriteBusLinesStorage.putNewOrRemove(busLine);
    getFavourites();
  }
}
