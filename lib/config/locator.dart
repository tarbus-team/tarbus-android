import 'package:get_it/get_it.dart';
import 'package:tarbus_app/config/app_config.dart';
import 'package:tarbus_app/data/remote/mpk_repository.dart';
import 'package:tarbus_app/data/remote/schedule_version_repository.dart';
import 'package:tarbus_app/manager/api.dart';
import 'package:tarbus_app/manager/query_controller.dart';

/// GetIt is dependecy injection service that will allow the locator instance to be located anywhere in the application.
/// The us case of this for now are the [services] and [Configuration] weather it is a prod or test enviroment.
final getIt = GetIt.I;
Future initLocator() async {
  getIt.registerLazySingleton(() => API());
  getIt.registerLazySingleton(() => GetAppConfigUseCaseImpl());
  // globalLocator.registerFactory(() => AuthRepo());
  getIt.registerLazySingleton(() => QueryController());
  getIt.registerLazySingleton(() => RemoteScheduleVersionRepository());
  getIt.registerLazySingleton(() => RemoteMpkRepository());
}
