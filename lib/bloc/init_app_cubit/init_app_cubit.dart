import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/bloc/schedule_version_cubit/schedule_version_cubit.dart';
import 'package:tarbus_app/shared/error_handler.dart';

part 'init_app_state.dart';

class InitAppCubit extends Cubit<InitAppState> {
  final ScheduleVersionCubit _scheduleVersionCubit;

  InitAppCubit(this._scheduleVersionCubit) : super(InitStarted());

  Future<void> initApp(BuildContext context) async {
    try {
      emit(InitLoading());
      _scheduleVersionCubit.stream.listen((event) {
        if (event is ScheduleEmpty) {
          emit(FirstAppRun());
        }
        if (event is ScheduleOutOfDate) {
          emit(UpdatingSchedule());
          _scheduleVersionCubit.downloadVersions();
        }
        if (event is ScheduleUpToDate) {
          emit(InitSuccess());
        }
      });
      await _scheduleVersionCubit.validateSavedScheduleVersions(context);
    } on ErrorExceptions {
      emit(InitFailure(
          error:
              "Nie można połączyć z serwerem.\nSprawdź swoje połączenie z siecią"));
    }
  }
}
