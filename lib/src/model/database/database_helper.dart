import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tarbus2021/src/model/api/response/response_last_updated.dart';
import 'package:tarbus2021/src/model/entity/bus_line.dart';
import 'package:tarbus2021/src/model/entity/bus_stop.dart';
import 'package:tarbus2021/src/model/entity/departure.dart';
import 'package:tarbus2021/src/model/entity/route_holder.dart';
import 'package:tarbus2021/src/model/entity/track_route.dart';

class DatabaseHelper {
  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

// only have a single app-wide reference to the database
  static Database db;

  Future<Database> get database async {
    const NEW_DB_VERSION = 7;
    //const NEW_DB_VERSION = 3;
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'tarbus.db');

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // This will get initiate only on the first time you launch your application

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      var data = await rootBundle.load(join('assets', 'tarbus.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {}

    // open the database
    db = await openDatabase(path, readOnly: false);
    if (await db.getVersion() < NEW_DB_VERSION) {
      db.close();

      //delete the old database so you can copy the new one
      await deleteDatabase(path);

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      //copy db from assets to database folder
      ByteData data = await rootBundle.load(join('assets', 'tarbus.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);

      db = await openDatabase(path, readOnly: false);
      //set the new version to the copied db so you do not need to do it manually on your bundled database.db
      db.setVersion(NEW_DB_VERSION);
    }
    return db;
  }

  void updateScheduleDate(ResponseLastUpdated lastUpdated) async {
    final db = await database;
    var query =
        'UPDATE LastUpdated SET year = ${lastUpdated.year}, month = ${lastUpdated.month}, day = ${lastUpdated.day}, hour = ${lastUpdated.hour}, min = ${lastUpdated.min} WHERE id = 1';
    var response = await db.rawQuery(query);
  }

  void doSQL(String query) async {
    var test = query;
    final db = await database;
    var response = await db.rawQuery(query);
  }

  Future<bool> clearAllDatabase() async {
    final db = await database;
    var query = 'DELETE FROM BusLine';
    var response = await db.rawQuery(query);
    query = 'DELETE FROM BusStop';
    response = await db.rawQuery(query);
    query = 'DELETE FROM BusStopConnection';
    response = await db.rawQuery(query);
    query = 'DELETE FROM Departure';
    response = await db.rawQuery(query);
    query = 'DELETE FROM DayType';
    response = await db.rawQuery(query);
    query = 'DELETE FROM Destinations';
    response = await db.rawQuery(query);
    query = 'DELETE FROM RoadType';
    response = await db.rawQuery(query);
    query = 'DELETE FROM Route';
    response = await db.rawQuery(query);
    query = 'DELETE FROM RouteConnections';
    response = await db.rawQuery(query);
    query = 'DELETE FROM Track';
    response = await db.rawQuery(query);
    return true;
  }

  Future<bool> checkIfAlertExist(var id) async {
    var query = 'SELECT id FROM AlertHistory WHERE id = $id';
    final db = await database;
    var response = await db.rawQuery(query);
    if (response.isNotEmpty) {
      return false;
    }
    return true;
  }

  void addDialogToList(var id) async {
    var query = 'INSERT INTO AlertHistory (id) VALUES($id)';
    final db = await database;
    var response = await db.rawQuery(query);
  }

  Future<List<BusStop>> getSearchedBusStops(List<String> patterns) async {
    var buffer = new StringBuffer();
    var counter = 0;
    for (String pattern in patterns) {
      if (counter > 0) {
        buffer.write(" AND ");
      }
      buffer.write(' bs_search_name LIKE "%$pattern%"');
      counter++;
    }
    var query = 'SELECT * FROM BusStop WHERE ${buffer.toString()}';
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    List<BusStop> busStops = response.map((c) => BusStop.fromJson(c)).toList();
    for (BusStop busStop in busStops) {
      busStop.routesFromBusStop = await getDestinationsByBusStopId(busStop.id);
    }
    return busStops;
  }

  Future<List<TrackRoute>> getDestinationsByBusStopId(var id) async {
    var query = 'SELECT * FROM Route WHERE Route.r_id IN (SELECT DISTINCT t_route_id FROM Departure JOIN Track ON Departure.d_track_id = Track.t_id'
        ' WHERE d_bus_stop_id = $id)';
    final db = await database;
    var response = await db.rawQuery(query);
    List<TrackRoute> routes = response.map((c) => TrackRoute.fromJson(c)).toList();
    return routes;
  }

  Future<List<Departure>> getDeparturesByBusStopId(var id) async {
    var query = 'SELECT * FROM Departure JOIN BusStop ON BusStop.bs_id = Departure.d_bus_stop_id JOIN Track ON Departure.d_track_id = Track.t_id '
        'JOIN BusLine ON BusLine.bl_id = Departure.d_bus_line_id JOIN Route ON Track.t_route_id = Route.r_id JOIN Destinations ON Departure.d_symbols '
        '= Destinations.ds_symbol AND Destinations.ds_route_id = Route.r_id WHERE Departure.d_bus_stop_id = $id';
    final db = await database;
    var response = await db.rawQuery(query);
    List<Departure> departures = response.map((c) => Departure.fromJson(c)).toList()..sort((a, b) => a.realTime.compareTo(b.realTime));
    return departures;
  }

  Future<List<Departure>> getAllDeparturesByDayType(var busStopId, var dayTypes) async {
    var query = "SELECT * FROM Departure JOIN BusStop ON BusStop.bs_id = Departure.d_bus_stop_id JOIN Track ON Departure.d_track_id = Track.t_id "
        "JOIN BusLine ON BusLine.bl_id = Departure.d_bus_line_id JOIN Route ON Track.t_route_id = Route.r_id JOIN Destinations ON Departure"
        ".d_symbols = Destinations.ds_symbol AND Destinations.ds_route_id = Route.r_id WHERE Departure.d_bus_stop_id = $busStopId AND Track"
        ".t_day_id IN ($dayTypes)";
    final db = await database;
    var response = await db.rawQuery(query);
    List<Departure> departures = response.map((c) => Departure.fromJson(c)).toList()..sort((a, b) => a.realTime.compareTo(b.realTime));
    return departures;
  }

  Future<List<RouteHolder>> getRouteDetailsByLineId(var lineId) async {
    print("getRouteDetailsByLineId( $lineId )");
    var query = 'SELECT * FROM Route WHERE Route.r_bus_line_id = $lineId';
    final db = await database;
    var response = await db.rawQuery(query);
    List<TrackRoute> trackRoutes = response.map((c) => TrackRoute.fromJson(c)).toList();
    List<RouteHolder> routeHolders = <RouteHolder>[];
    for (TrackRoute trackRoute in trackRoutes) {
      List<BusStop> busStops = await getBusStopsByRouteId(trackRoute.id);
      routeHolders.add(RouteHolder(trackRoute: trackRoute, busStops: busStops));
    }
    return routeHolders;
  }

  Future<List<Departure>> getDeparturesByTrackId(var id) async {
    var query = 'SELECT * FROM Departure JOIN BusStop ON BusStop.bs_id = Departure.d_bus_stop_id WHERE Departure.d_track_id = \'$id\' ORDER BY '
        'Departure.d_bus_stop_lp';
    final db = await database;
    var response = await db.rawQuery(query);
    List<Departure> departures = response.map((c) => Departure.fromJson(c)).toList();
    return departures;
  }

  Future<List<BusStop>> getAllBusStops() async {
    var query = 'SELECT * FROM BusStop';
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    List<BusStop> busStops = response.map((c) => BusStop.fromJson(c)).toList();
    return busStops;
  }

  Future<List<BusLine>> getAllBusLines() async {
    var query = 'SELECT * FROM BusLine WHERE NOT bl_id = 0 ';
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    List<BusLine> busLines = response.map((c) => BusLine.fromJson(c)).toList();
    return busLines;
  }

  Future<List<BusStop>> getBusStopsByRouteId(var routeId) async {
    var query = 'SELECT * FROM RouteConnections JOIN BusStop ON BusStop.bs_id = RouteConnections.rc_bus_stop_id WHERE RouteConnections.rc_route_id '
        '= $routeId ORDER BY rc_lp';
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    List<BusStop> busStops = response.map((c) => BusStop.fromJsonRoute(c)).toList();
    return busStops;
  }

  Future<ResponseLastUpdated> getLastSavedUpdateDate() async {
    var query = 'SELECT * FROM LastUpdated WHERE id = 1';
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    List<ResponseLastUpdated> lastupdate = response.map((c) => ResponseLastUpdated.fromJson(c)).toList();
    if (lastupdate.isEmpty) {
      final db = await database;
      var query = "INSERT INTO LastUpdated (id, year,month,day,hour,min) VALUES(1,0,0,0,0,0)";
      var response = await db.rawQuery(query);
      return ResponseLastUpdated(year: 0, month: 0, day: 0, hour: 0, min: 0);
    }
    return lastupdate[0];
  }
}
