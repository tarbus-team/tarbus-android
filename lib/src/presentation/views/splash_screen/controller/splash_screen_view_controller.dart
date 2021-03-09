import 'dart:async';
import 'dart:convert';

import 'package:tarbus2021/src/model/api/repository.dart';
import 'package:tarbus2021/src/model/api/response/response_last_updated.dart';
import 'package:tarbus2021/src/model/api/response/response_welcome_dialog.dart';
import 'package:tarbus2021/src/model/api/response/response_welcome_message.dart';
import 'package:tarbus2021/src/model/database/database_helper.dart';
import 'package:tarbus2021/src/model/entity/app_start_settings.dart';
import 'package:tarbus2021/src/utils/connection_utils.dart';
import 'package:tarbus2021/src/utils/json_databaase_utils.dart';

enum ScheduleStatus { actual, old, noConnection }

class SplashScreenViewController {
  ScheduleStatus scheduleStatus;
  ResponseLastUpdated lastUpdated;
  AppStartSettings appStartSettings;

  SplashScreenViewController();

  Future<ResponseLastUpdated> getLastUpdateDate() async {
    return await DatabaseHelper.instance.getLastSavedUpdateDate();
  }

  Future<ResponseWelcomeMessage> getWelcomeMessage() async {
    return await Repository.getClient().getWelcomeMessage();
  }

  Future<ResponseWelcomeDialog> getAlertDialog() async {
    return await Repository.getClient().getAlertDialog();
  }

  Future<bool> checkIfShowAlert(var id) {
    return DatabaseHelper.instance.checkIfAlertExist(id);
  }

  Future<bool> setSettingsOffline() async {
    appStartSettings = AppStartSettings();
    appStartSettings.lastUpdated = await getLastUpdateDate();
    appStartSettings.welcomeMessage = ResponseWelcomeMessage.offline();
    appStartSettings.hasDialog = false;
    appStartSettings.isOnline = false;
    scheduleStatus = ScheduleStatus.noConnection;
    return false;
  }

  Future<bool> setSettingsOnline() async {
    appStartSettings = AppStartSettings();
    appStartSettings.lastUpdated = await getLastUpdateDate();
    appStartSettings.welcomeMessage = await getWelcomeMessage();
    appStartSettings.dialogContent = await getAlertDialog();
    if (appStartSettings.dialogContent == null || appStartSettings.dialogContent.id == 0) {
      appStartSettings.hasDialog = false;
    } else {
      appStartSettings.hasDialog = await checkIfShowAlert(appStartSettings.dialogContent.id);
    }
    appStartSettings.isOnline = true;
    return true;
  }

  Future<bool> init() async {
    if (!await ConnectionUtils.checkInternetStatus()) {
      return setSettingsOffline();
    } else {
      return setSettingsOnline();
    }
  }

  Future<ScheduleStatus> checkForUpdates() async {
    if (scheduleStatus == ScheduleStatus.noConnection) return ScheduleStatus.noConnection;
    var remoteLastUpdate = await Repository.getClient().getLastUpdateDate();
    var localLastUpdate = appStartSettings.lastUpdated;
    lastUpdated = remoteLastUpdate;
    if (remoteLastUpdate.equal(localLastUpdate)) {
      return ScheduleStatus.actual;
    }
    return ScheduleStatus.old;
  }

  Future<bool> updateIfExpired() async {
    if (scheduleStatus == ScheduleStatus.noConnection) return false;
    if (scheduleStatus == ScheduleStatus.actual) {
      return true;
    } else {
      if (await DatabaseHelper.instance.clearAllDatabase()) {
        String newDatabaseString = await Repository.getClient().getNewDatabase();
        JsonDatabaseUtils dbResponse = JsonDatabaseUtils.fromJson(jsonDecode(newDatabaseString));
        DatabaseHelper.instance.updateScheduleDate(lastUpdated);
        appStartSettings.lastUpdated = lastUpdated;
        return dbResponse.operationStatus;
      }
    }
    return false;
  }
}
