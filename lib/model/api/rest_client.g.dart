// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://dpajak99.github.io/tarbus-api/v2-1-3/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ResponseLastUpdated> getLastUpdateDate() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/last-update.json',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'GET', headers: <String, dynamic>{}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    final value = ResponseLastUpdated.fromJson(_result.data);
    return value;
  }

  @override
  Future<String> getNewDatabase() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<String>('/database.json',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'GET', headers: <String, dynamic>{}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<ResponseWelcomeMessage> getWelcomeMessage() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/message.json',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'GET', headers: <String, dynamic>{}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    final value = ResponseWelcomeMessage.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseWelcomeDialog> getAlertDialog() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/alert-dialog.json',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'GET', headers: <String, dynamic>{}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    final value = ResponseWelcomeDialog.fromJson(_result.data);
    return value;
  }
}
