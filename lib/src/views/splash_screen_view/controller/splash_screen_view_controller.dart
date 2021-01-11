import 'package:tarbus2021/src/database/database_helper.dart';
import 'package:tarbus2021/src/model/last_updated.dart';
import 'package:tarbus2021/src/remote/json_service.dart';
import 'package:tarbus2021/src/services/app_internet.dart';

enum ScheduleStatus { actual, old, noConnection }

class SplashScreenViewController {
  ScheduleStatus scheduleStatus;
  LastUpdated lastUpdated;

  SplashScreenViewController();

  Future<ScheduleStatus> checkForUpdates() async {
    if (!await AppInternet.checkInternetStatus()) {
      return ScheduleStatus.noConnection;
    }
    LastUpdated remoteLastUpdate = await JsonService.getLastUpdateDate();
    LastUpdated localLastUpdate = await DatabaseHelper.instance.getLastSavedUpdateDate();

    lastUpdated = remoteLastUpdate;

    if (remoteLastUpdate.equal(localLastUpdate)) {
      return ScheduleStatus.actual;
    }
    return ScheduleStatus.old;
  }

  Future<bool> updateIfExpired() async {
    if (scheduleStatus == ScheduleStatus.actual) {
      return true;
    } else {
      if (await DatabaseHelper.instance.clearAllDatabase()) {
        bool status = await JsonService.getNewDatabase();
        DatabaseHelper.instance.updateScheduleDate(lastUpdated);
        return status;
      }
    }
    return false;
  }
}
