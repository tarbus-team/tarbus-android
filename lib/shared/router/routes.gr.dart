// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i20;
import 'package:flutter/cupertino.dart' as _i23;
import 'package:flutter/material.dart' as _i21;
import 'package:tarbus_app/data/model/departure_wrapper.dart' as _i28;
import 'package:tarbus_app/data/model/schedule/bus_line.dart' as _i27;
import 'package:tarbus_app/data/model/schedule/bus_stop.dart' as _i25;
import 'package:tarbus_app/data/model/schedule/track.dart' as _i24;
import 'package:tarbus_app/data/model/schedule/track_route.dart' as _i26;
import 'package:tarbus_app/shared/guards/gps_guard.dart' as _i22;
import 'package:tarbus_app/views/pages/add_favourite_bus_stop_page/add_favourite_bus_stop_page.dart'
    as _i11;
import 'package:tarbus_app/views/pages/app_bus_lines_page/app_bus_lines_page.dart'
    as _i16;
import 'package:tarbus_app/views/pages/app_home_page/app_home_page.dart'
    as _i15;
import 'package:tarbus_app/views/pages/app_map_page/app_map_page.dart' as _i17;
import 'package:tarbus_app/views/pages/app_menu_page/app_menu_page.dart'
    as _i19;
import 'package:tarbus_app/views/pages/app_search_page/app_search_page.dart'
    as _i18;
import 'package:tarbus_app/views/pages/app_wrapper.dart' as _i13;
import 'package:tarbus_app/views/pages/departure_details_page/departure_details_page.dart'
    as _i9;
import 'package:tarbus_app/views/pages/departures_page/departures_page.dart'
    as _i8;
import 'package:tarbus_app/views/pages/first_config_page/first_config_page.dart'
    as _i2;
import 'package:tarbus_app/views/pages/line_details_page/line_details_page.dart'
    as _i12;
import 'package:tarbus_app/views/pages/map_lines_stops_page/map_line_stops_page.dart'
    as _i6;
import 'package:tarbus_app/views/pages/map_route_stops_page/map_route_stops_page.dart'
    as _i7;
import 'package:tarbus_app/views/pages/map_track_page/track_map_page.dart'
    as _i4;
import 'package:tarbus_app/views/pages/not_found.dart' as _i14;
import 'package:tarbus_app/views/pages/permission_page.dart' as _i10;
import 'package:tarbus_app/views/pages/search_list_page/search_list_page.dart'
    as _i3;
import 'package:tarbus_app/views/pages/settings_page/settings_page.dart' as _i5;
import 'package:tarbus_app/views/pages/splash_screen_page/splash_screen_page.dart'
    as _i1;

class AppRouter extends _i20.RootStackRouter {
  AppRouter(
      {_i21.GlobalKey<_i21.NavigatorState>? navigatorKey,
      required this.gpsGuard})
      : super(navigatorKey);

  final _i22.GpsGuard gpsGuard;

  @override
  final Map<String, _i20.PageFactory> pagesMap = {
    InitialRoute.name: (routeData) {
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData, child: _i1.SplashScreenPage());
    },
    FirstConfigRoute.name: (routeData) {
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData, child: _i2.FirstConfigPage());
    },
    SearchListRoute.name: (routeData) {
      final args = routeData.argsAs<SearchListRouteArgs>();
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i3.SearchListPage(
              key: args.key,
              type: args.type,
              wantsFavourite: args.wantsFavourite));
    },
    TrackMapRoute.name: (routeData) {
      final args = routeData.argsAs<TrackMapRouteArgs>();
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i4.TrackMapPage(
              key: args.key, track: args.track, busStop: args.busStop));
    },
    SettingsRoute.name: (routeData) {
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData, child: _i5.SettingsPage());
    },
    MapLineStopsRoute.name: (routeData) {
      final args = routeData.argsAs<MapLineStopsRouteArgs>();
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i6.MapLineStopsPage(
              key: args.key,
              busLineId: args.busLineId,
              busLineName: args.busLineName));
    },
    MapRouteStopsRoute.name: (routeData) {
      final args = routeData.argsAs<MapRouteStopsRouteArgs>();
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i7.MapRouteStopsPage(key: args.key, route: args.route));
    },
    DeparturesRoute.name: (routeData) {
      final args = routeData.argsAs<DeparturesRouteArgs>();
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i8.DeparturesPage(
              key: args.key,
              busStopName: args.busStopName,
              busStopId: args.busStopId,
              busLine: args.busLine));
    },
    DepartureDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DepartureDetailsRouteArgs>();
      return _i20.CustomPage<dynamic>(
          routeData: routeData,
          child: _i9.DepartureDetailsPage(
              key: args.key, departureWrapper: args.departureWrapper),
          opaque: true,
          barrierDismissible: false);
    },
    PermissionsRoute.name: (routeData) {
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData, child: _i10.PermissionPage());
    },
    AddFavouriteBusStopRoute.name: (routeData) {
      final args = routeData.argsAs<AddFavouriteBusStopRouteArgs>();
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i11.AddFavouriteBusStopPage(
              key: args.key, busStop: args.busStop));
    },
    LineDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<LineDetailsRouteArgs>();
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i12.LineDetailsPage(
              key: args.key,
              busLineId: args.busLineId,
              busLineName: args.busLineName));
    },
    AppRoute.name: (routeData) {
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData, child: _i13.AppWrapper());
    },
    NotFoundRoute.name: (routeData) {
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData, child: _i14.NotFoundPage());
    },
    AppHomeRoute.name: (routeData) {
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData, child: _i15.AppHomePage());
    },
    AppBusLinesRoute.name: (routeData) {
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData, child: _i16.AppBusLinesPage());
    },
    AppMapRoute.name: (routeData) {
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData, child: _i17.AppMapPage());
    },
    AppSearchRoute.name: (routeData) {
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData, child: _i18.AppSearchPage());
    },
    AppMenuRoute.name: (routeData) {
      return _i20.AdaptivePage<dynamic>(
          routeData: routeData, child: _i19.AppMenuPage());
    }
  };

  @override
  List<_i20.RouteConfig> get routes => [
        _i20.RouteConfig(InitialRoute.name, path: '/'),
        _i20.RouteConfig(FirstConfigRoute.name, path: '/appConfig'),
        _i20.RouteConfig(SearchListRoute.name, path: '/search'),
        _i20.RouteConfig(TrackMapRoute.name, path: '/track-map'),
        _i20.RouteConfig(SettingsRoute.name, path: '/settings'),
        _i20.RouteConfig(MapLineStopsRoute.name, path: '/lines-stops-map'),
        _i20.RouteConfig(MapRouteStopsRoute.name, path: '/route-stops-map'),
        _i20.RouteConfig(DeparturesRoute.name, path: '/departure'),
        _i20.RouteConfig(DepartureDetailsRoute.name,
            path: '/departure-details'),
        _i20.RouteConfig(PermissionsRoute.name, path: '/allow-permissions'),
        _i20.RouteConfig(AddFavouriteBusStopRoute.name,
            path: '/add-favourite-bus-stop'),
        _i20.RouteConfig(LineDetailsRoute.name, path: 'routes'),
        _i20.RouteConfig(AppRoute.name, path: '/app', guards: [
          gpsGuard
        ], children: [
          _i20.RouteConfig(AppHomeRoute.name,
              path: 'home', parent: AppRoute.name),
          _i20.RouteConfig(AppBusLinesRoute.name,
              path: 'lines', parent: AppRoute.name),
          _i20.RouteConfig(AppMapRoute.name,
              path: 'map', parent: AppRoute.name),
          _i20.RouteConfig(AppSearchRoute.name,
              path: 'search', parent: AppRoute.name),
          _i20.RouteConfig(AppMenuRoute.name,
              path: 'menu', parent: AppRoute.name)
        ]),
        _i20.RouteConfig(NotFoundRoute.name, path: '/Not_Found_404_error'),
        _i20.RouteConfig('*#redirect',
            path: '*', redirectTo: '/Not_Found_404_error', fullMatch: true)
      ];
}

/// generated route for [_i1.SplashScreenPage]
class InitialRoute extends _i20.PageRouteInfo<void> {
  const InitialRoute() : super(name, path: '/');

  static const String name = 'InitialRoute';
}

/// generated route for [_i2.FirstConfigPage]
class FirstConfigRoute extends _i20.PageRouteInfo<void> {
  const FirstConfigRoute() : super(name, path: '/appConfig');

  static const String name = 'FirstConfigRoute';
}

/// generated route for [_i3.SearchListPage]
class SearchListRoute extends _i20.PageRouteInfo<SearchListRouteArgs> {
  SearchListRoute({_i23.Key? key, required String type, bool? wantsFavourite})
      : super(name,
            path: '/search',
            args: SearchListRouteArgs(
                key: key, type: type, wantsFavourite: wantsFavourite));

  static const String name = 'SearchListRoute';
}

class SearchListRouteArgs {
  const SearchListRouteArgs(
      {this.key, required this.type, this.wantsFavourite});

  final _i23.Key? key;

  final String type;

  final bool? wantsFavourite;
}

/// generated route for [_i4.TrackMapPage]
class TrackMapRoute extends _i20.PageRouteInfo<TrackMapRouteArgs> {
  TrackMapRoute(
      {_i23.Key? key, required _i24.Track track, required _i25.BusStop busStop})
      : super(name,
            path: '/track-map',
            args: TrackMapRouteArgs(key: key, track: track, busStop: busStop));

  static const String name = 'TrackMapRoute';
}

class TrackMapRouteArgs {
  const TrackMapRouteArgs(
      {this.key, required this.track, required this.busStop});

  final _i23.Key? key;

  final _i24.Track track;

  final _i25.BusStop busStop;
}

/// generated route for [_i5.SettingsPage]
class SettingsRoute extends _i20.PageRouteInfo<void> {
  const SettingsRoute() : super(name, path: '/settings');

  static const String name = 'SettingsRoute';
}

/// generated route for [_i6.MapLineStopsPage]
class MapLineStopsRoute extends _i20.PageRouteInfo<MapLineStopsRouteArgs> {
  MapLineStopsRoute(
      {_i23.Key? key, required int busLineId, required String busLineName})
      : super(name,
            path: '/lines-stops-map',
            args: MapLineStopsRouteArgs(
                key: key, busLineId: busLineId, busLineName: busLineName));

  static const String name = 'MapLineStopsRoute';
}

class MapLineStopsRouteArgs {
  const MapLineStopsRouteArgs(
      {this.key, required this.busLineId, required this.busLineName});

  final _i23.Key? key;

  final int busLineId;

  final String busLineName;
}

/// generated route for [_i7.MapRouteStopsPage]
class MapRouteStopsRoute extends _i20.PageRouteInfo<MapRouteStopsRouteArgs> {
  MapRouteStopsRoute({_i23.Key? key, required _i26.TrackRoute route})
      : super(name,
            path: '/route-stops-map',
            args: MapRouteStopsRouteArgs(key: key, route: route));

  static const String name = 'MapRouteStopsRoute';
}

class MapRouteStopsRouteArgs {
  const MapRouteStopsRouteArgs({this.key, required this.route});

  final _i23.Key? key;

  final _i26.TrackRoute route;
}

/// generated route for [_i8.DeparturesPage]
class DeparturesRoute extends _i20.PageRouteInfo<DeparturesRouteArgs> {
  DeparturesRoute(
      {_i23.Key? key,
      String? busStopName,
      required int busStopId,
      _i27.BusLine? busLine})
      : super(name,
            path: '/departure',
            args: DeparturesRouteArgs(
                key: key,
                busStopName: busStopName,
                busStopId: busStopId,
                busLine: busLine));

  static const String name = 'DeparturesRoute';
}

class DeparturesRouteArgs {
  const DeparturesRouteArgs(
      {this.key, this.busStopName, required this.busStopId, this.busLine});

  final _i23.Key? key;

  final String? busStopName;

  final int busStopId;

  final _i27.BusLine? busLine;
}

/// generated route for [_i9.DepartureDetailsPage]
class DepartureDetailsRoute
    extends _i20.PageRouteInfo<DepartureDetailsRouteArgs> {
  DepartureDetailsRoute(
      {_i23.Key? key, required _i28.DepartureWrapper departureWrapper})
      : super(name,
            path: '/departure-details',
            args: DepartureDetailsRouteArgs(
                key: key, departureWrapper: departureWrapper));

  static const String name = 'DepartureDetailsRoute';
}

class DepartureDetailsRouteArgs {
  const DepartureDetailsRouteArgs({this.key, required this.departureWrapper});

  final _i23.Key? key;

  final _i28.DepartureWrapper departureWrapper;
}

/// generated route for [_i10.PermissionPage]
class PermissionsRoute extends _i20.PageRouteInfo<void> {
  const PermissionsRoute() : super(name, path: '/allow-permissions');

  static const String name = 'PermissionsRoute';
}

/// generated route for [_i11.AddFavouriteBusStopPage]
class AddFavouriteBusStopRoute
    extends _i20.PageRouteInfo<AddFavouriteBusStopRouteArgs> {
  AddFavouriteBusStopRoute({_i23.Key? key, required _i25.BusStop busStop})
      : super(name,
            path: '/add-favourite-bus-stop',
            args: AddFavouriteBusStopRouteArgs(key: key, busStop: busStop));

  static const String name = 'AddFavouriteBusStopRoute';
}

class AddFavouriteBusStopRouteArgs {
  const AddFavouriteBusStopRouteArgs({this.key, required this.busStop});

  final _i23.Key? key;

  final _i25.BusStop busStop;
}

/// generated route for [_i12.LineDetailsPage]
class LineDetailsRoute extends _i20.PageRouteInfo<LineDetailsRouteArgs> {
  LineDetailsRoute(
      {_i23.Key? key, required int busLineId, required String busLineName})
      : super(name,
            path: 'routes',
            args: LineDetailsRouteArgs(
                key: key, busLineId: busLineId, busLineName: busLineName));

  static const String name = 'LineDetailsRoute';
}

class LineDetailsRouteArgs {
  const LineDetailsRouteArgs(
      {this.key, required this.busLineId, required this.busLineName});

  final _i23.Key? key;

  final int busLineId;

  final String busLineName;
}

/// generated route for [_i13.AppWrapper]
class AppRoute extends _i20.PageRouteInfo<void> {
  const AppRoute({List<_i20.PageRouteInfo>? children})
      : super(name, path: '/app', initialChildren: children);

  static const String name = 'AppRoute';
}

/// generated route for [_i14.NotFoundPage]
class NotFoundRoute extends _i20.PageRouteInfo<void> {
  const NotFoundRoute() : super(name, path: '/Not_Found_404_error');

  static const String name = 'NotFoundRoute';
}

/// generated route for [_i15.AppHomePage]
class AppHomeRoute extends _i20.PageRouteInfo<void> {
  const AppHomeRoute() : super(name, path: 'home');

  static const String name = 'AppHomeRoute';
}

/// generated route for [_i16.AppBusLinesPage]
class AppBusLinesRoute extends _i20.PageRouteInfo<void> {
  const AppBusLinesRoute() : super(name, path: 'lines');

  static const String name = 'AppBusLinesRoute';
}

/// generated route for [_i17.AppMapPage]
class AppMapRoute extends _i20.PageRouteInfo<void> {
  const AppMapRoute() : super(name, path: 'map');

  static const String name = 'AppMapRoute';
}

/// generated route for [_i18.AppSearchPage]
class AppSearchRoute extends _i20.PageRouteInfo<void> {
  const AppSearchRoute() : super(name, path: 'search');

  static const String name = 'AppSearchRoute';
}

/// generated route for [_i19.AppMenuPage]
class AppMenuRoute extends _i20.PageRouteInfo<void> {
  const AppMenuRoute() : super(name, path: 'menu');

  static const String name = 'AppMenuRoute';
}
