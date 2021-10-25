import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

// only have a single app-wide reference to the database
  static late Database db;

  Future<Database> get database async {
    const NEW_DB_VERSION = 11;
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
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {}

    // open the database
    db = await openDatabase(path, readOnly: false);
    if (await db.getVersion() < NEW_DB_VERSION) {
      await db.close();

      //delete the old database so you can copy the new one
      await deleteDatabase(path);

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      //copy db from assets to database folder
      var data = await rootBundle.load(join('assets', 'tarbus.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);

      db = await openDatabase(path, readOnly: false);
      //set the new version to the copied db so you do not need to do it manually on your bundled database.db
      await db.setVersion(NEW_DB_VERSION);
    }
    return db;
  }

  Future<List<Map<String, dynamic>>> doSQL(String query) async {
    final db = await database;
    return await db.rawQuery(query);
  }

  Future<void> doSQLVoid(String query) async {
    final db = await database;
    await db.rawQuery(query);
  }

  Future<bool> clearDatabase(String subscribeCode) async {
    // Version version = await VersionDatabase.getVersionBySubscribeCode(subscribeCode);
    await doSQL(
        'DELETE FROM Versions WHERE v_subscribe_code = \'$subscribeCode\'');
    return true;
  }

  Future<bool> clearAllDatabase() async {
    var tablesToDelete = [
      'BusLine',
      'BusStop',
      'BusStopConnection',
      'Departure',
      'Calendar',
      'Destinations',
      'Route',
      'RouteConnections',
      'Track',
      'Company',
      'Versions',
    ];
    for (var table in tablesToDelete) {
      await doSQL('DELETE FROM $table');
    }
    return true;
  }
}
