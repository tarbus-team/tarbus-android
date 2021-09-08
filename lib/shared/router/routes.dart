import 'package:auto_route/auto_route.dart';
import 'package:tarbus_app/shared/guards/gps_guard.dart';
import 'package:tarbus_app/views/pages/add_favourite_bus_stop_page/add_favourite_bus_stop_page.dart';
import 'package:tarbus_app/views/pages/app_bus_lines_page/app_bus_lines_page.dart';
import 'package:tarbus_app/views/pages/app_home_page/app_home_page.dart';
import 'package:tarbus_app/views/pages/app_map_page/app_map_page.dart';
import 'package:tarbus_app/views/pages/app_menu_page/app_menu_page.dart';
import 'package:tarbus_app/views/pages/app_search_page/app_search_page.dart';
import 'package:tarbus_app/views/pages/app_wrapper.dart';
import 'package:tarbus_app/views/pages/departure_details_page/departure_details_page.dart';
import 'package:tarbus_app/views/pages/departures_page/departures_page.dart';
import 'package:tarbus_app/views/pages/first_config_page/first_config_page.dart';
import 'package:tarbus_app/views/pages/line_details_page/line_details_page.dart';
import 'package:tarbus_app/views/pages/map_lines_stops_page/map_line_stops_page.dart';
import 'package:tarbus_app/views/pages/map_route_stops_page/map_route_stops_page.dart';
import 'package:tarbus_app/views/pages/map_track_page/track_map_page.dart';
import 'package:tarbus_app/views/pages/not_found.dart';
import 'package:tarbus_app/views/pages/permission_page.dart';
import 'package:tarbus_app/views/pages/search_list_page/search_list_page.dart';
import 'package:tarbus_app/views/pages/settings_page/settings_page.dart';
import 'package:tarbus_app/views/pages/splash_screen_page/splash_screen_page.dart';

@AdaptiveAutoRouter(replaceInRouteName: 'Page,Route', routes: [
  AutoRoute(
    page: SplashScreenPage,
    name: "InitialRoute",
    initial: true,
    path: "/",
  ),
  AutoRoute(
    page: FirstConfigPage,
    name: "FirstConfigRoute",
    path: "/appConfig",
  ),
  AutoRoute(
    page: SearchListPage,
    name: "SearchListRoute",
    path: "/search",
  ),
  AutoRoute(
    page: TrackMapPage,
    name: "TrackMapRoute",
    path: "/track-map",
  ),
  AutoRoute(
    page: SettingsPage,
    name: "SettingsRoute",
    path: "/settings",
  ),
  AutoRoute(
    page: MapLineStopsPage,
    name: "MapLineStopsRoute",
    path: "/lines-stops-map",
  ),
  AutoRoute(
    page: MapRouteStopsPage,
    name: "MapRouteStopsRoute",
    path: "/route-stops-map",
  ),
  AutoRoute(
    page: DeparturesPage,
    name: "DeparturesRoute",
    path: "/departure",
  ),
  CustomRoute(
    page: DepartureDetailsPage,
    name: "DepartureDetailsRoute",
    path: "/departure-details",
  ),
  AutoRoute(
    page: PermissionPage,
    name: "PermissionsRoute",
    path: "/allow-permissions",
  ),
  AutoRoute(
    page: AddFavouriteBusStopPage,
    name: "AddFavouriteBusStopRoute",
    path: "/add-favourite-bus-stop",
  ),
  AutoRoute(
    page: LineDetailsPage,
    name: "LineDetailsRoute",
    path: "routes",
  ),
  AutoRoute(page: AppWrapper, name: "AppRoute", path: "/app", guards: [
    GpsGuard
  ], children: [
    AutoRoute(
      page: AppHomePage,
      name: "AppHomeRoute",
      path: "home",
    ),
    AutoRoute(
      page: AppBusLinesPage,
      name: "AppBusLinesRoute",
      path: "lines",
    ),
    AutoRoute(
      page: AppMapPage,
      name: "AppMapRoute",
      path: "map",
    ),
    AutoRoute(
      page: AppSearchPage,
      name: "AppSearchRoute",
      path: "search",
    ),
    AutoRoute(
      page: AppMenuPage,
      name: "AppMenuRoute",
      path: "menu",
    ),
  ]),

  AutoRoute(
      page: NotFoundPage, name: "NotFoundRoute", path: "/Not_Found_404_error"),
  RedirectRoute(path: "*", redirectTo: "/Not_Found_404_error")
  // AutoRoute()
])
class $AppRouter {}
