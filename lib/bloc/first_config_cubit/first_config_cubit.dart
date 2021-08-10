import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/bloc/schedule_version_cubit/schedule_version_cubit.dart';
import 'package:tarbus_app/data/model/available_version_model.dart';
import 'package:tarbus_app/data/model/available_versions_response.dart';
import 'package:tarbus_app/data/remote/schedule_version_repository.dart';
import 'package:tarbus_app/shared/error_handler.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';

part 'first_config_state.dart';

class FirstConfigCubit extends Cubit<FirstConfigState> {
  final ScheduleVersionRepository scheduleVersionRepository;
  final ScheduleVersionCubit scheduleVersionCubit;

  FirstConfigCubit(
      {required this.scheduleVersionRepository,
      required this.scheduleVersionCubit})
      : super(FirstConfigLoading());

  Future<void> fetchAvailableVersions(BuildContext context) async {
    try {
      final response = await scheduleVersionRepository.getAvailableVersions();
      emit(FirstConfigLoaded(availableVersionsResponse: response));
    } on ErrorExceptions {
      emit(FirstConfigFailure(
          error: "Couldn't fetch weather. Is the device online?"));
    }
  }

  Future<void> saveVersions(BuildContext context,
      List<AvailableVersionModel> selectedVersions) async {
    emit(FirstConfigDownloading());
    await scheduleVersionCubit.setUpNewVersions(selectedVersions);
    context.router.replace(AppRoute());
  }
}
