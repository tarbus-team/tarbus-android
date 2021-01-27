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
    const NEW_DB_VERSION = 9;
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

  Future<List<Map<String, dynamic>>> doSQL(String query) async {
    final db = await database;
    return await db.rawQuery(query);
  }

  void doSQLVoid(String query) async {
    final db = await database;
    await db.rawQuery(query);
  }

  void updateScheduleDate(ResponseLastUpdated lastUpdated) async {
    var query =
        'UPDATE LastUpdated SET year = ${lastUpdated.year}, month = ${lastUpdated.month}, day = ${lastUpdated.day}, hour = ${lastUpdated.hour}, min = ${lastUpdated.min} WHERE id = 1';
    var response = await doSQL(query);
  }

  Future<bool> clearAllDatabase() async {
    var tablesToDelete = [
      'BusLine',
      'BusStop',
      'BusStopConnection',
      'Departure',
      'DayType',
      'Destinations',
      'RoadType',
      'Route',
      'RouteConnections',
      'Track'
    ];
    for (var table in tablesToDelete) {
      var response = await doSQL('DELETE FROM $table');
    }
    return true;
  }

  Future<bool> checkIfAlertExist(var id) async {
    var query = 'SELECT id FROM AlertHistory WHERE id = $id';
    var response = await doSQL(query);
    if (response.isNotEmpty) {
      return false;
    }
    return true;
  }

  void addDialogToList(var id) async {
    var query = 'INSERT INTO AlertHistory (id) VALUES($id)';
    var response = await doSQL(query);
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
    var response = await doSQL(query);
    List<BusStop> busStops = response.map((c) => BusStop.fromJson(c)).toList();
    return busStops;
  }

  Future<List<Departure>> getDeparturesByBusStopId(var id) async {
    var query = 'SELECT * FROM Departure '
        'JOIN BusStop ON BusStop.bs_id = Departure.d_bus_stop_id '
        'JOIN Track ON Departure.d_track_id = Track.t_id '
        'JOIN BusLine ON BusLine.bl_id = Departure.d_bus_line_id '
        'JOIN Route ON Track.t_route_id = Route.r_id '
        'JOIN Destinations ON Departure.d_symbols = Destinations.ds_symbol AND Destinations.ds_route_id = Route.r_id '
        'WHERE Departure.d_bus_stop_id = $id';

    var response = await doSQL(query);
    List<Departure> departures = response.map((c) => Departure.fromJson(c)).toList()..sort((a, b) => a.timeInMin.compareTo(b.timeInMin));
    return departures;
  }

  Future<List<Departure>> getAllDeparturesByDayType(var busStopId, var dayTypes) async {
    var query = "SELECT * FROM Departure "
        "JOIN BusStop ON BusStop.bs_id = Departure.d_bus_stop_id "
        "JOIN Track ON Departure.d_track_id = Track.t_id "
        "JOIN BusLine ON BusLine.bl_id = Departure.d_bus_line_id "
        "JOIN Route ON Track.t_route_id = Route.r_id "
        "JOIN Destinations ON Departure.d_symbols = Destinations.ds_symbol AND Destinations.ds_route_id = Route.r_id "
        "WHERE Departure.d_bus_stop_id = $busStopId "
        "AND Track.t_day_id IN ($dayTypes)";

    var response = await doSQL(query);
    List<Departure> departures = response.map((c) => Departure.fromJson(c)).toList()..sort((a, b) => a.timeInMin.compareTo(b.timeInMin));
    return departures;
  }

  Future<List<RouteHolder>> getRouteDetailsByLineId(var lineId) async {
    var query = 'SELECT * FROM Route WHERE Route.r_bus_line_id = $lineId';
    var response = await doSQL(query);
    List<TrackRoute> trackRoutes = response.map((c) => TrackRoute.fromJson(c)).toList();
    List<RouteHolder> routeHolders = <RouteHolder>[];
    for (TrackRoute trackRoute in trackRoutes) {
      List<BusStop> busStops = await getBusStopsByRouteId(trackRoute.id);
      routeHolders.add(RouteHolder(trackRoute: trackRoute, busStops: busStops));
    }
    return routeHolders;
  }

  Future<List<Departure>> getDeparturesByTrackId(var id) async {
    print("id: $id");
    var query = 'SELECT * FROM Departure '
        'JOIN BusStop ON BusStop.bs_id = Departure.d_bus_stop_id '
        'WHERE Departure.d_track_id = \'$id\' '
        'ORDER BY Departure.d_bus_stop_lp';

    var response = await doSQL(query);
    print("response: $response");
    List<Departure> departures = response.map((c) => Departure.fromJson(c)).toList();
    return departures;
  }

  Future<List<BusStop>> getAllBusStops() async {
    var query = 'SELECT * FROM BusStop';
    var response = await doSQL(query);
    List<BusStop> busStops = response.map((c) => BusStop.fromJson(c)).toList();
    return busStops;
  }

  Future<List<BusLine>> getAllBusLines() async {
    var query = 'SELECT * FROM BusLine';
    var response = await doSQL(query);
    List<BusLine> busLines = response.map((c) => BusLine.fromJson(c)).toList();
    return busLines;
  }

  Future<List<BusStop>> getBusStopsByRouteId(var routeId) async {
    var query = 'SELECT * FROM RouteConnections '
        'JOIN BusStop ON BusStop.bs_id = RouteConnections.rc_bus_stop_id '
        'WHERE RouteConnections.rc_route_id = $routeId ORDER BY rc_lp';

    var response = await doSQL(query);
    List<BusStop> busStops = response.map((c) => BusStop.fromJsonRoute(c)).toList();
    return busStops;
  }

  Future<ResponseLastUpdated> getLastSavedUpdateDate() async {
    var query = 'SELECT * FROM LastUpdated WHERE id = 1';
    var response = await doSQL(query);
    if (response.isEmpty) {
      final db = await database;
      var query = "INSERT INTO LastUpdated (id, year,month,day,hour,min) VALUES(1,0,0,0,0,0)";
      var response = await db.rawQuery(query);
      return ResponseLastUpdated(year: 0, month: 0, day: 0, hour: 0, min: 0);
    } else {
      List<ResponseLastUpdated> lastupdate = response.map((c) => ResponseLastUpdated.fromJson(c)).toList();
      return lastupdate[0];
    }
  }
}
