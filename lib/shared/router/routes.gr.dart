// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/cupertino.dart' as _i22;
import 'package:flutter/material.dart' as _i2;
import 'package:tarbus_app/data/model/schedule/bus_line.dart' as _i26;
import 'package:tarbus_app/data/model/schedule/bus_stop.dart' as _i23;
import 'package:tarbus_app/data/model/schedule/departure.dart' as _i27;
import 'package:tarbus_app/data/model/schedule/track.dart' as _i24;
import 'package:tarbus_app/data/model/schedule/track_route.dart' as _i25;
import 'package:tarbus_app/shared/guards/gps_guard.dart' as _i3;
import 'package:tarbus_app/views/pages/app_bus_lines_page/app_bus_lines_page.dart'
    as _i20;
import 'package:tarbus_app/views/pages/app_bus_lines_page/app_bus_lines_wrapper.dart'
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
    as _i11;
import 'package:tarbus_app/views/pages/departures_page/departures_page.dart'
    as _i10;
import 'package:tarbus_app/views/pages/first_config_page/first_config_page.dart'
    as _i5;
import 'package:tarbus_app/views/pages/line_details_page/line_details_page.dart'
    as _i21;
import 'package:tarbus_app/views/pages/map_lines_stops_page/map_line_stops_page.dart'
    as _i8;
import 'package:tarbus_app/views/pages/map_route_stops_page/map_route_stops_page.dart'
    as _i9;
import 'package:tarbus_app/views/pages/map_track_page/track_map_page.dart'
    as _i7;
import 'package:tarbus_app/views/pages/not_found.dart' as _i14;
import 'package:tarbus_app/views/pages/permission_page.dart' as _i12;
import 'package:tarbus_app/views/pages/search_list_page/search_list_page.dart'
    as _i6;
import 'package:tarbus_app/views/pages/splash_screen_page/splash_screen_page.dart'
    as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter(
      {_i2.GlobalKey<_i2.NavigatorState>? navigatorKey, required this.gpsGuard})
      : super(navigatorKey);

  final _i3.GpsGuard gpsGuard;

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    InitialRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i4.SplashScreenPage());
    },
    FirstConfigRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i5.FirstConfigPage());
    },
    SearchListRoute.name: (routeData) {
      final args = routeData.argsAs<SearchListRouteArgs>(
          orElse: () => const SearchListRouteArgs());
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i6.SearchListPage(
              key: args.key, onBusStopSelected: args.onBusStopSelected));
    },
    TrackMapRoute.name: (routeData) {
      final args = routeData.argsAs<TrackMapRouteArgs>();
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i7.TrackMapPage(
              key: args.key, track: args.track, busStop: args.busStop));
    },
    MapLineStopsRoute.name: (routeData) {
      final args = routeData.argsAs<MapLineStopsRouteArgs>();
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i8.MapLineStopsPage(
              key: args.key,
              busLineId: args.busLineId,
              busLineName: args.busLineName));
    },
    MapRouteStopsRoute.name: (routeData) {
      final args = routeData.argsAs<MapRouteStopsRouteArgs>();
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i9.MapRouteStopsPage(key: args.key, route: args.route));
    },
    DeparturesRoute.name: (routeData) {
      final args = routeData.argsAs<DeparturesRouteArgs>();
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i10.DeparturesPage(
              key: args.key,
              busStopName: args.busStopName,
              busStopId: args.busStopId,
              busLine: args.busLine));
    },
    DepartureDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DepartureDetailsRouteArgs>();
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i11.DepartureDetailsPage(
              key: args.key, departure: args.departure));
    },
    PermissionsRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i12.PermissionPage());
    },
    AppRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i13.AppWrapper());
    },
    NotFoundRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i14.NotFoundPage());
    },
    AppHomeRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i15.AppHomePage());
    },
    AppBusLinesWrapper.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i16.AppBusLinesWrapper());
    },
    AppMapRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i17.AppMapPage());
    },
    AppSearchRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i18.AppSearchPage());
    },
    AppMenuRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i19.AppMenuPage());
    },
    AppBusLinesRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i20.AppBusLinesPage());
    },
    LineDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<LineDetailsRouteArgs>();
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i21.LineDetailsPage(
              key: args.key,
              busLineId: args.busLineId,
              busLineName: args.busLineName));
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(InitialRoute.name, path: '/'),
        _i1.RouteConfig(FirstConfigRoute.name, path: '/appConfig'),
        _i1.RouteConfig(SearchListRoute.name, path: '/search'),
        _i1.RouteConfig(TrackMapRoute.name, path: '/track-map'),
        _i1.RouteConfig(MapLineStopsRoute.name, path: '/lines-stops-map'),
        _i1.RouteConfig(MapRouteStopsRoute.name, path: '/route-stops-map'),
        _i1.RouteConfig(DeparturesRoute.name, path: '/departure'),
        _i1.RouteConfig(DepartureDetailsRoute.name, path: '/departure-details'),
        _i1.RouteConfig(PermissionsRoute.name, path: '/allow-permissions'),
        _i1.RouteConfig(AppRoute.name, path: '/app', guards: [
          gpsGuard
        ], children: [
          _i1.RouteConfig(AppHomeRoute.name, path: 'home'),
          _i1.RouteConfig(AppBusLinesWrapper.name, path: 'lines', children: [
            _i1.RouteConfig(AppBusLinesRoute.name, path: 'all'),
            _i1.RouteConfig(LineDetailsRoute.name, path: 'routes'),
            _i1.RouteConfig('#redirect',
                path: '', redirectTo: 'all', fullMatch: true)
          ]),
          _i1.RouteConfig(AppMapRoute.name, path: 'map'),
          _i1.RouteConfig(AppSearchRoute.name, path: 'search'),
          _i1.RouteConfig(AppMenuRoute.name, path: 'menu')
        ]),
        _i1.RouteConfig(NotFoundRoute.name, path: '/Not_Found_404_error'),
        _i1.RouteConfig('*#redirect',
            path: '*', redirectTo: '/Not_Found_404_error', fullMatch: true)
      ];
}

class InitialRoute extends _i1.PageRouteInfo {
  const InitialRoute() : super(name, path: '/');

  static const String name = 'InitialRoute';
}

class FirstConfigRoute extends _i1.PageRouteInfo {
  const FirstConfigRoute() : super(name, path: '/appConfig');

  static const String name = 'FirstConfigRoute';
}

class SearchListRoute extends _i1.PageRouteInfo<SearchListRouteArgs> {
  SearchListRoute(
      {_i22.Key? key, dynamic Function(_i23.BusStop)? onBusStopSelected})
      : super(name,
            path: '/search',
            args: SearchListRouteArgs(
                key: key, onBusStopSelected: onBusStopSelected));

  static const String name = 'SearchListRoute';
}

class SearchListRouteArgs {
  const SearchListRouteArgs({this.key, this.onBusStopSelected});

  final _i22.Key? key;

  final dynamic Function(_i23.BusStop)? onBusStopSelected;
}

class TrackMapRoute extends _i1.PageRouteInfo<TrackMapRouteArgs> {
  TrackMapRoute(
      {_i22.Key? key, required _i24.Track track, required _i23.BusStop busStop})
      : super(name,
            path: '/track-map',
            args: TrackMapRouteArgs(key: key, track: track, busStop: busStop));

  static const String name = 'TrackMapRoute';
}

class TrackMapRouteArgs {
  const TrackMapRouteArgs(
      {this.key, required this.track, required this.busStop});

  final _i22.Key? key;

  final _i24.Track track;

  final _i23.BusStop busStop;
}

class MapLineStopsRoute extends _i1.PageRouteInfo<MapLineStopsRouteArgs> {
  MapLineStopsRoute(
      {_i22.Key? key, required int busLineId, required String busLineName})
      : super(name,
            path: '/lines-stops-map',
            args: MapLineStopsRouteArgs(
                key: key, busLineId: busLineId, busLineName: busLineName));

  static const String name = 'MapLineStopsRoute';
}

class MapLineStopsRouteArgs {
  const MapLineStopsRouteArgs(
      {this.key, required this.busLineId, required this.busLineName});

  final _i22.Key? key;

  final int busLineId;

  final String busLineName;
}

class MapRouteStopsRoute extends _i1.PageRouteInfo<MapRouteStopsRouteArgs> {
  MapRouteStopsRoute({_i22.Key? key, required _i25.TrackRoute route})
      : super(name,
            path: '/route-stops-map',
            args: MapRouteStopsRouteArgs(key: key, route: route));

  static const String name = 'MapRouteStopsRoute';
}

class MapRouteStopsRouteArgs {
  const MapRouteStopsRouteArgs({this.key, required this.route});

  final _i22.Key? key;

  final _i25.TrackRoute route;
}

class DeparturesRoute extends _i1.PageRouteInfo<DeparturesRouteArgs> {
  DeparturesRoute(
      {_i22.Key? key,
      String? busStopName,
      required int busStopId,
      _i26.BusLine? busLine})
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

  final _i22.Key? key;

  final String? busStopName;

  final int busStopId;

  final _i26.BusLine? busLine;
}

class DepartureDetailsRoute
    extends _i1.PageRouteInfo<DepartureDetailsRouteArgs> {
  DepartureDetailsRoute({_i22.Key? key, required _i27.Departure departure})
      : super(name,
            path: '/departure-details',
            args: DepartureDetailsRouteArgs(key: key, departure: departure));

  static const String name = 'DepartureDetailsRoute';
}

class DepartureDetailsRouteArgs {
  const DepartureDetailsRouteArgs({this.key, required this.departure});

  final _i22.Key? key;

  final _i27.Departure departure;
}

class PermissionsRoute extends _i1.PageRouteInfo {
  const PermissionsRoute() : super(name, path: '/allow-permissions');

  static const String name = 'PermissionsRoute';
}

class AppRoute extends _i1.PageRouteInfo {
  const AppRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/app', children: children);

  static const String name = 'AppRoute';
}

class NotFoundRoute extends _i1.PageRouteInfo {
  const NotFoundRoute() : super(name, path: '/Not_Found_404_error');

  static const String name = 'NotFoundRoute';
}

class AppHomeRoute extends _i1.PageRouteInfo {
  const AppHomeRoute() : super(name, path: 'home');

  static const String name = 'AppHomeRoute';
}

class AppBusLinesWrapper extends _i1.PageRouteInfo {
  const AppBusLinesWrapper({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'lines', children: children);

  static const String name = 'AppBusLinesWrapper';
}

class AppMapRoute extends _i1.PageRouteInfo {
  const AppMapRoute() : super(name, path: 'map');

  static const String name = 'AppMapRoute';
}

class AppSearchRoute extends _i1.PageRouteInfo {
  const AppSearchRoute() : super(name, path: 'search');

  static const String name = 'AppSearchRoute';
}

class AppMenuRoute extends _i1.PageRouteInfo {
  const AppMenuRoute() : super(name, path: 'menu');

  static const String name = 'AppMenuRoute';
}

class AppBusLinesRoute extends _i1.PageRouteInfo {
  const AppBusLinesRoute() : super(name, path: 'all');

  static const String name = 'AppBusLinesRoute';
}

class LineDetailsRoute extends _i1.PageRouteInfo<LineDetailsRouteArgs> {
  LineDetailsRoute(
      {_i22.Key? key, required int busLineId, required String busLineName})
      : super(name,
            path: 'routes',
            args: LineDetailsRouteArgs(
                key: key, busLineId: busLineId, busLineName: busLineName));

  static const String name = 'LineDetailsRoute';
}

class LineDetailsRouteArgs {
  const LineDetailsRouteArgs(
      {this.key, required this.busLineId, required this.busLineName});

  final _i22.Key? key;

  final int busLineId;

  final String busLineName;
}
