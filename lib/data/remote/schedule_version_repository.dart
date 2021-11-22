import 'package:dio/dio.dart';
import 'package:tarbus_app/data/model/available_versions_response.dart';
import 'package:tarbus_app/manager/api_manager.dart';

abstract class ScheduleVersionRepository {
  /// Throws [ErrorExceptions].
  Future<Map<String, dynamic>> getLatestUpdate();

  /// Throws [ErrorExceptions].
  Future<AvailableVersionsResponse> getAvailableVersions();

  /// Throws [ErrorExceptions].
  Future<List<dynamic>> getDatabaseFile({
    required String subscribeCode,
    required ProgressCallback onReceiveProgress,
  });
}

class RemoteScheduleVersionRepository extends ScheduleVersionRepository {
  ApiManager _apiManager = ApiManager('https://api.tarbus.pl/');

  Future<AvailableVersionsResponse> getAvailableVersions() async {
    final _response = await _apiManager.get(path: '/static/config/available-versions.json');
    return AvailableVersionsResponse.fromJSON(_response.data);
  }

  Future<List<dynamic>> getDatabaseFile(
      {required String subscribeCode, required ProgressCallback onReceiveProgress}) async {
    final _response = await _apiManager.get(
      path: '/static/database/$subscribeCode.json',
      onReceiveProgress: onReceiveProgress,
    );
    return _response.data;
  }

  Future<Map<String, dynamic>> getLatestUpdate() async {
    final _response = await _apiManager.get(path: '/static/config/database-info.json');
    return _response.data;
  }
}
