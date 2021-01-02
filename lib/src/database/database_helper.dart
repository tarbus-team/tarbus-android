import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tarbus2021/src/model/bus_stop.dart';
import 'package:tarbus2021/src/model/departure.dart';
import 'package:tarbus2021/src/model/single_destination.dart';
import 'package:tarbus2021/src/model/track.dart';

class DatabaseHelper {
  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

// only have a single app-wide reference to the database
  static Database db;

  Future<Database> get database async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "tarbus.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // This will get initiate only on the first time you launch your application
      print("Creating new copy from asset >>>");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "tarbus.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      //DB ALready exists return the db
      print("Opening existing database >>>");
    }

    // open the database
    db = await openDatabase(path, readOnly: true);
    return db;
  }

  Future<List<BusStop>> getAllBusStops() async {
    String query = "SELECT * FROM BusStop";
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

  Future<List<SingleDestination>> getBusStopRoute(int id) async {
    String query = "SELECT DISTINCT destination_name FROM Destination JOIN Track ON track_destination_id = destination_id JOIN Departure ON "
        "departure_track_id = track_id JOIN BusStop ON bus_stop_number = departure_bus_stop_number WHERE bus_stop_number = $id";
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    List<SingleDestination> list = response.map((c) => SingleDestination.fromJson(c)).toList();
    return list;
  }

  Future<List<Departure>> getDeparturesByBusStopId(int busStopId) async {
    String query = "SELECT * FROM Departure JOIN BusStop ON Departure.departure_bus_stop_number = BusStop.bus_stop_number JOIN BusLine ON Departure"
        ".departure_bus_line_id = BusLine.bus_line_id JOIN Track ON Departure.departure_track_id = Track.track_id JOIN Destination ON Track"
        ".track_destination_id = Destination.destination_id WHERE Departure.departure_bus_stop_number = $busStopId ORDER BY time_in_sec";
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    print(response.toString());
    List<Departure> list = response.map((c) => Departure.fromJson(c)).toList();
    return list;
  }

  /// **************TESTS***********************/

  Future<List<Track>> getAllTracks() async {
    String query = "SELECT * FROM Track, Destination WHERE track_destination_id = destination_id ";
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    List<Track> list = response.map((c) => Track.fromJson(c)).toList();
    return list;
  }

  Future<List<Departure>> getDeparturesByTrackId(int trackId) async {
    String query = "SELECT * FROM Departure JOIN BusStop ON Departure.departure_bus_stop_number = BusStop.bus_stop_number JOIN BusLine ON Departure"
        ".departure_bus_line_id = BusLine.bus_line_id JOIN Track ON Departure.departure_track_id = Track.track_id JOIN Destination ON Track"
        ".track_destination_id = Destination.destination_id WHERE track_id = $trackId ORDER BY time_in_sec";
    final db = await database;
    //Using a RAW Query here to fetch the list of data
    var response = await db.rawQuery(query);
    print(response.toString());
    List<Departure> list = response.map((c) => Departure.fromJson(c)).toList();
    return list;
  }
}
