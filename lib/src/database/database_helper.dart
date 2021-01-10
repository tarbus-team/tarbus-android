import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tarbus2021/src/model/bus_line.dart';
import 'package:tarbus2021/src/model/bus_stop.dart';
import 'package:tarbus2021/src/model/departure.dart';
import 'package:tarbus2021/src/model/destination.dart';
import 'package:tarbus2021/src/model/last_updated.dart';
import 'package:tarbus2021/src/model/route_holder.dart';
import 'package:tarbus2021/src/model/single_destination.dart';
import 'package:tarbus2021/src/model/track.dart';

class DatabaseHelper {
  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

// only have a single app-wide reference to the database
  static Database db;

  Future<Database> get database async {
    const NEW_DB_VERSION = 3;
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

  void updateScheduleDate(LastUpdated lastUpdated) async {
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
    var query = 'DELETE FROM BusStop';
    var response = await db.rawQuery(query);
    query = 'DELETE FROM Departure';
    response = await db.rawQuery(query);
    query = 'DELETE FROM BusLine';
    response = await db.rawQuery(query);
    query = 'DELETE FROM DayType';
    response = await db.rawQuery(query);
    query = 'DELETE FROM Destination';
    response = await db.rawQuery(query);
    query = 'DELETE FROM Track';
    response = await db.rawQuery(query);

    return true;
  }

  Future<List<BusStop>> getSearchedBusStops(List<String> patterns) async {
    var buffer = new StringBuffer();
    var counter = 0;
    for (String pattern in patterns) {
      if (counter > 0) {
        buffer.write(" AND ");
      }
      buffer.write(' bus_stop_search_name LIKE "%$pattern%"');
      counter++;
    }
    var query = 'SELECT * FROM BusStop WHERE ${buffer.toString()}';
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    List<BusStop> busStops = response.map((c) => BusStop.fromJson(c)).toList();
    for (BusStop busStop in busStops) {
      List<SingleDestination> result = await getBusStopRoute(busStop.number);
      busStop.destinations = result;
    }
    return busStops;
  }

  Future<List<BusStop>> getAllBusStops() async {
    var query = 'SELECT * FROM BusStop';
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    List<BusStop> busStops = response.map((c) => BusStop.fromJson(c)).toList();
    for (BusStop busStop in busStops) {
      List<SingleDestination> result = await getBusStopRoute(busStop.number);
      busStop.destinations = result;
    }
    return busStops;
  }

  Future<LastUpdated> getLastSavedUpdateDate() async {
    var query = 'SELECT * FROM LastUpdated WHERE id = 1';
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    List<LastUpdated> lastupdate = response.map((c) => LastUpdated.fromJson(c)).toList();
    return lastupdate[0];
  }

  Future<List<SingleDestination>> getBusStopRoute(int id) async {
    var query = 'SELECT DISTINCT destination_name FROM Destination JOIN Track ON track_destination_id = destination_id JOIN Departure ON '
        'departure_track_id = track_id JOIN BusStop ON bus_stop_number = departure_bus_stop_number WHERE bus_stop_number = $id';
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    var list = response.map((c) => SingleDestination.fromJson(c)).toList();
    return list;
  }

  Future<List<Departure>> getDeparturesByBusStopId(int busStopId) async {
    var query = 'SELECT * FROM Departure JOIN BusStop ON Departure.departure_bus_stop_number = BusStop.bus_stop_number JOIN BusLine ON Departure '
        '.departure_bus_line_id = BusLine.bus_line_id JOIN Track ON Departure.departure_track_id = Track.track_id JOIN Destination ON Track '
        '.track_destination_id = Destination.destination_id WHERE Departure.departure_bus_stop_number = $busStopId ORDER BY time_in_sec';
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    var list = response.map((c) => Departure.fromJson(c)).toList()..sort((a, b) => a.realTime.compareTo(b.realTime));
    return list;
  }

  Future<List<Track>> getAllTracks() async {
    var query = 'SELECT * FROM Track, Destination WHERE track_destination_id = destination_id ';
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    var list = response.map((c) => Track.fromJson(c)).toList();
    return list;
  }

  Future<List<Departure>> getDeparturesByTrackId(String trackId) async {
    var query = 'SELECT * FROM Departure JOIN BusStop ON Departure.departure_bus_stop_number = BusStop.bus_stop_number JOIN BusLine ON Departure '
        '.departure_bus_line_id = BusLine.bus_line_id JOIN Track ON Departure.departure_track_id = Track.track_id JOIN Destination ON Track '
        '.track_destination_id = Destination.destination_id WHERE track_id = \'$trackId\' ORDER BY time_in_sec';
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    var list = response.map((c) => Departure.fromJson(c)).toList()..sort((a, b) => a.realTime.compareTo(b.realTime));
    ;
    return list;
  }

  Future<List<BusLine>> getAllBusLines() async {
    var query = 'SELECT * FROM BusLine';
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    var list = response.map((c) => BusLine.fromJson(c)).toList();
    return list;
  }

  Future<List<Departure>> getAllDeparturesByDayType(int busStopId, String dayTypes) async {
    var query = 'SELECT * FROM Departure JOIN BusStop ON Departure.departure_bus_stop_number = BusStop.bus_stop_number JOIN BusLine ON Departure '
        '.departure_bus_line_id = BusLine.bus_line_id JOIN Track ON Departure.departure_track_id = Track.track_id JOIN Destination ON Track '
        '.track_destination_id = Destination.destination_id WHERE Departure.departure_bus_stop_number = $busStopId AND Track.day_type IN '
        '($dayTypes) ORDER BY time_in_sec';

    final db = await database;
    var response = await db.rawQuery(query);
    var list = response.map((c) => Departure.fromJson(c)).toList()..sort((a, b) => a.realTime.compareTo(b.realTime));
    return list;
  }

  Future<List<RouteHolder>> getAllDestinationsByBysLineId(int busLineId) async {
    var routeHolderList = <RouteHolder>[];
    var query = 'SELECT * FROM Destination WHERE destination_bus_line_id = $busLineId AND destination_id NOT IN(SELECT ignored_destination_id '
        'FROM IgnoredDestinations)';
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    var list = response.map((c) => Destination.fromJson(c)).toList();
    for (var destination in list) {
      var query = 'SELECT * FROM BusStop JOIN Departure ON Departure.departure_bus_stop_number = BusStop.bus_stop_number JOIN Track ON Departure '
          '.departure_track_id = Track.track_id WHERE Track.track_id = (SELECT Track.track_id FROM Track WHERE Track.track_destination_id = '
          '${destination.id} LIMIT 1)';
      final db = await database;
      //Using a RAW Query here to fetch the list of data
      var response2 = await db.rawQuery(query);
      var departureList = response2.map((c) => Departure.fromJson(c)).toList()..sort((a, b) => a.realTime.compareTo(b.realTime));
      var busStopList = <BusStop>[];
      for (Departure departure in departureList) {
        busStopList.add(departure.busStop);
      }
      var routeHolder = RouteHolder(destination: destination, busStops: busStopList);
      //print(routeHolder.toString());
      routeHolderList.add(routeHolder);
    }
    return routeHolderList;
  }
}
