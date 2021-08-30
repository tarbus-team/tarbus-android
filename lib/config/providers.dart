import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:tarbus_app/bloc/app_cubit/app_cubit.dart';
import 'package:tarbus_app/bloc/bus_lines_cubit/bus_lines_cubit.dart';
import 'package:tarbus_app/bloc/departure_details_cubit/departure_details_cubit.dart';
import 'package:tarbus_app/bloc/departures_cubit/departures_cubit.dart';
import 'package:tarbus_app/bloc/departures_mini_cubit/departures_mini_cubit.dart';
import 'package:tarbus_app/bloc/favourite_bus_stops_cubit/favourite_bus_stops_cubit.dart';
import 'package:tarbus_app/bloc/first_config_cubit/first_config_cubit.dart';
import 'package:tarbus_app/bloc/gps_cubit/gps_cubit.dart';
import 'package:tarbus_app/bloc/init_app_cubit/init_app_cubit.dart';
import 'package:tarbus_app/bloc/map_cubit/map_cubit.dart';
import 'package:tarbus_app/bloc/routes_cubit/routes_cubit.dart';
import 'package:tarbus_app/bloc/schedule_version_cubit/schedule_version_cubit.dart';
import 'package:tarbus_app/bloc/search_cubit/search_cubit.dart';
import 'package:tarbus_app/bloc/search_hint_cubit/search_hint_cubit.dart';
import 'package:tarbus_app/bloc/timetable_departures_cubit/timetable_departures_cubit.dart';
import 'package:tarbus_app/config/locator.dart';
import 'package:tarbus_app/data/remote/schedule_version_repository.dart';
import 'package:tarbus_app/manager/query_controller.dart';

final List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<QueryController>.value(
      value: getIt<QueryController>()),
  BlocProvider<ScheduleVersionCubit>(
    lazy: false,
    create: (context) =>
        ScheduleVersionCubit(getIt<RemoteScheduleVersionRepository>()),
  ),
  BlocProvider<SearchCubit>(
    lazy: false,
    create: (context) => SearchCubit(),
  ),
  BlocProvider<RoutesCubit>(
    lazy: false,
    create: (context) => RoutesCubit(),
  ),
  BlocProvider<AppCubit>(
    lazy: false,
    create: (context) => AppCubit(),
  ),
  BlocProvider<TimetableDeparturesCubit>(
    lazy: false,
    create: (context) => TimetableDeparturesCubit(),
  ),
  BlocProvider<DepartureDetailsCubit>(
    lazy: false,
    create: (context) => DepartureDetailsCubit(),
  ),
  BlocProvider<DeparturesCubit>(
    lazy: false,
    create: (context) => DeparturesCubit(),
  ),
  BlocProvider<DeparturesMiniCubit>(
    lazy: false,
    create: (context) => DeparturesMiniCubit(),
  ),
  BlocProvider<BusLinesCubit>(
    lazy: false,
    create: (context) => BusLinesCubit(),
  ),
  BlocProvider<FavouriteBusStopsCubit>(
    lazy: false,
    create: (context) => FavouriteBusStopsCubit(),
  ),
  BlocProvider<FirstConfigCubit>(
    lazy: false,
    create: (context) => FirstConfigCubit(
      scheduleVersionRepository: getIt<RemoteScheduleVersionRepository>(),
      scheduleVersionCubit: BlocProvider.of<ScheduleVersionCubit>(context),
    ),
  ),
  BlocProvider<InitAppCubit>(
    lazy: false,
    create: (context) => InitAppCubit(
      BlocProvider.of<ScheduleVersionCubit>(context),
    ),
  ),
  BlocProvider<GpsCubit>(
    lazy: false,
    create: (context) => GpsCubit(),
  ),
  BlocProvider<BusStopsMapCubit>(
    lazy: false,
    create: (context) => BusStopsMapCubit(
      gpsCubit: BlocProvider.of<GpsCubit>(context),
    ),
  ),
  BlocProvider<TrackMapCubit>(
    lazy: false,
    create: (context) => TrackMapCubit(
      gpsCubit: BlocProvider.of<GpsCubit>(context),
    ),
  ),
  BlocProvider<SearchHintCubit>(
    lazy: false,
    create: (context) => SearchHintCubit(
      gpsCubit: BlocProvider.of<GpsCubit>(context),
    ),
  ),
];
