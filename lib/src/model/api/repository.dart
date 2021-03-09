import 'package:dio/dio.dart';
import 'package:tarbus2021/src/model/api/rest_client.dart';

class Repository {
  static RestClient getClient() {
    final _dio = Dio();
    final _client = RestClient(_dio);
    return _client;
  }
}
