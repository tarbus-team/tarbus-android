import 'dart:async';
import 'dart:convert';

import 'package:tarbus2021/app/app_consts.dart';
import 'package:tarbus2021/model/api/repository.dart';
import 'package:tarbus2021/model/api/response/response_last_updated.dart';
import 'package:tarbus2021/model/api/response/response_welcome_dialog.dart';
import 'package:tarbus2021/model/api/response/response_welcome_message.dart';
import 'package:tarbus2021/model/database/database_helper.dart';
import 'package:tarbus2021/model/entity/app_start_settings.dart';
import 'package:tarbus2021/utils/connection_utils.dart';
import 'package:tarbus2021/utils/json_databaase_utils.dart';
import 'package:tarbus2021/utils/shared_preferences_utils.dart';

enum ScheduleStatus { actual, old, noConnection }

class SplashScreenViewController {
  ScheduleStatus scheduleStatus;
  ResponseLastUpdated lastUpdated;
  AppStartSettings settings;

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

  Future<bool> setSettingsOffline() async {
    settings = AppStartSettings()
      ..lastUpdated = await getLastUpdateDate()
      ..welcomeMessage = ResponseWelcomeMessage.offline()
      ..hasDialog = false
      ..isOnline = false;

    scheduleStatus = ScheduleStatus.noConnection;
    return false;
  }

  Future<bool> setSettingsOnline() async {
    settings = AppStartSettings()
      ..lastUpdated = await getLastUpdateDate()
      ..welcomeMessage = await getWelcomeMessage()
      ..dialogContent = await getAlertDialog();

    if (settings.dialogContent == null || settings.dialogContent.id == 0) {
      settings.hasDialog = false;
    } else {
      settings.hasDialog = !await SharedPreferencesUtils.checkIfExist(
          AppConsts.SharedPreferencesDialog, settings.dialogContent.id.toString());
    }
    settings.isOnline = true;
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
    var localLastUpdate = settings.lastUpdated;
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
        var newDatabaseString = await Repository.getClient().getNewDatabase();
        var dbResponse = JsonDatabaseUtils.fromJson(jsonDecode(newDatabaseString) as List<dynamic>);
        DatabaseHelper.instance.updateScheduleDate(lastUpdated);
        settings.lastUpdated = lastUpdated;
        return dbResponse.operationStatus;
      }
    }
    return false;
  }
}
