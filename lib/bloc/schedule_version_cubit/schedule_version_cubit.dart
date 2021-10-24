import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/data/model/available_version_model.dart';
import 'package:tarbus_app/data/remote/schedule_version_repository.dart';
import 'package:tarbus_app/data/storage_model/subscribed_version_model.dart';
import 'package:tarbus_app/data/subscribed_schedule_storage.dart';
import 'package:tarbus_app/manager/database.dart';
import 'package:tarbus_app/manager/json_databaase_parser.dart';
import 'package:tarbus_app/shared/error_handler.dart';

part 'schedule_version_state.dart';

class ScheduleVersionCubit extends Cubit<ScheduleVersionState> {
  final ScheduleVersionRepository _scheduleVersionRepository;

  ScheduleVersionCubit(this._scheduleVersionRepository)
      : super(ScheduleInitial());

  Future<void> validateSavedScheduleVersions(BuildContext context) async {
    // try {
    List<SubscribedVersionModel> expiredVersions = List.empty(growable: true);
    List<SubscribedVersionModel> removedVersions = List.empty(growable: true);
    emit(ScheduleChecking());
    final remoteVersions = await _scheduleVersionRepository.getLatestUpdate();
    final localVersions = SubscribedScheduleStorage.getSubscribedVersions();
    if (localVersions.isEmpty) {
      print('scheduleEmpty');
      emit(ScheduleEmpty());
      return;
    } else {
      localVersions.forEach((version) {
        if (!remoteVersions.containsKey(version.subscribeCode)) {
          removedVersions.add(version);
        } else if (remoteVersions[version.subscribeCode] !=
            version.updateDate) {
          expiredVersions.add(version);
        }
      });
    }

    if (expiredVersions.isNotEmpty) {
      emit(ScheduleOutOfDate());
    }
    if (removedVersions.isNotEmpty) {
      emit(ScheduleRemoved());
    }
    if (expiredVersions.isEmpty && removedVersions.isEmpty) {
      emit(ScheduleUpToDate());
    }
    emit(ScheduleCheckingFinished());
    // } on NetworkException {
    //   emit(WeatherError("Couldn't fetch weather. Is the device online?"));
    // }
  }

  Future<void> setUpNewVersions(
      List<AvailableVersionModel> selectedVersions) async {
    List<SubscribedVersionModel> subscribedVersions =
        List.empty(growable: true);
    selectedVersions.forEach((version) {
      subscribedVersions
          .add(SubscribedVersionModel.fromAvailableVersion(version));
    });
    await SubscribedScheduleStorage.updateSubscribedVersions(
        subscribedVersions);
    await downloadVersions();
  }

  Future<void> downloadVersions() async {
    try {
      emit(ScheduleDownloading());
      List<SubscribedVersionModel> activeVersions =
          SubscribedScheduleStorage.getSubscribedVersions();
      print(activeVersions);
      List<List<dynamic>> downloadedDatabases = List.empty(growable: true);
      for (SubscribedVersionModel version in activeVersions) {
        downloadedDatabases.add(await _scheduleVersionRepository
            .getVersionDatabase("template2-mpktarnow"));
      }
      await DatabaseHelper.instance.clearAllDatabase();
      for (List<dynamic> dbData in downloadedDatabases) {
        await JsonDatabaseParser.parse(dbData);
      }

      emit(ScheduleUpToDate());
    } on ErrorExceptions {
      emit(ScheduleFailure(
          error: "Wystąpił błąd w trakcie pobierania rozkładu"));
    }
  }
}
