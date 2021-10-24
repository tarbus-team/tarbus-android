import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tarbus_app/shared/error_handler.dart';

abstract class _IAPI {
  get(
      {required String? path,
      required Map<String, dynamic> header,
      Map<String, dynamic>? queryParam});

  put(dynamic data,
      {required String? path,
      Map<String, dynamic>? header,
      Map<String, dynamic>? queryParam});

  post(Map? data,
      {required String path,
      required Map<String, dynamic> header,
      Map<String, dynamic>? queryParam,
      bool needsAuth = false});

  delete();
}

class API implements _IAPI {
  late Dio _dio;
  late String? clientID, secureKeyApi;

  API() {
    // _dio = Dio(BaseOptions(baseUrl: 'https://dev-api.tarbus.pl/'));
    _dio = Dio(BaseOptions(baseUrl: 'http://192.168.43.45:8082/'));
  }

  @override
  delete() {
    throw UnimplementedError();
  }

  @override
  Future get(
      {required String? path,
      required Map<String, dynamic> header,
      bool useLocalhost = false,
      String? host,
      Map<String, dynamic>? queryParam}) async {
    try {
      late Dio finalDio;
      if (host != null) {
        finalDio = Dio(BaseOptions(baseUrl: host));
      } else {
        finalDio = _dio;
      }
      if (!useLocalhost) {
        final _res = await finalDio.get(path!,
            queryParameters: queryParam, options: Options(headers: header));
        print(_res.realUri);
        return _res.data;
      } else {
        final _res =
            await Dio(BaseOptions(baseUrl: 'http://192.168.43.45:8082/')).get(
                path!,
                queryParameters: queryParam,
                options: Options(headers: header));
        print(_res.realUri);
        return _res.data;
      }
    } on DioError catch (err) {
      print(err.stackTrace);
      throw ErrorExceptions.fromDioError(err);
    }
  }

  @override
  Future post(Map? data,
      {required String? path,
      required Map<String, dynamic> header,
      Map<String, dynamic>? queryParam,
      bool needsAuth = false}) async {
    try {
      var auth;

      if (needsAuth) {
        auth = 'Basic ' + base64Encode(utf8.encode('$clientID:$secureKeyApi'));
        header['Authorization'] = auth;
      }

      var _res = await _dio.post(path!,
          data: data,
          queryParameters: queryParam,
          options: Options(
              headers: header,
              contentType: needsAuth
                  ? 'application/x-www-form-urlencoded'
                  : 'application/json; charset=utf-8'));
      print("POST URI => ${_res.realUri}");
      print(data);
      return _res.data;
    } on DioError catch (err) {
      throw ErrorExceptions.fromDioError(err);
    }
  }

  @override
  Future put(dynamic data,
      {required String? path,
      Map<String, dynamic>? header,
      Map<String, dynamic>? queryParam}) async {
    try {
      final _res = await _dio.put(path!,
          data: data,
          queryParameters: queryParam,
          options: Options(headers: header));
      return _res.data;
    } on DioError catch (err) {
      throw ErrorExceptions.fromDioError(err);
    }
  }
}
