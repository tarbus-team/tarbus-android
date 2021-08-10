import 'package:tarbus_app/config/locator.dart';
import 'package:tarbus_app/data/model/available_versions_response.dart';
import 'package:tarbus_app/manager/api.dart';

abstract class ScheduleVersionRepository {
  /// Throws [ErrorExceptions].
  Future<Map<String, dynamic>> getLatestUpdate();

  /// Throws [ErrorExceptions].
  Future<AvailableVersionsResponse> getAvailableVersions();

  /// Throws [ErrorExceptions].
  Future<List<dynamic>> getVersionDatabase(String subscribeCode);
}

class RemoteScheduleVersionRepository extends ScheduleVersionRepository {
  Future<AvailableVersionsResponse> getAvailableVersions() async {
    final _response = await getIt<API>()
        .get(path: '/static/config/available-versions.json', header: {});
    return AvailableVersionsResponse.fromJSON(_response);
  }

  Future<List<dynamic>> getVersionDatabase(String subscribeCode) async {
    final _response = await getIt<API>()
        .get(path: '/static/database/$subscribeCode.json', header: {});
    return _response;
  }

  Future<Map<String, dynamic>> getLatestUpdate() async {
    final _response = await getIt<API>()
        .get(path: '/static/config/database-info.json', header: {});
    print(_response);
    return _response;
  }
}
