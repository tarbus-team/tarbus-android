import 'package:dio/dio.dart';

class ErrorExceptions implements Exception {
  String? message;
  ErrorExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = 'Request to server was cancelled';
        break;
      case DioErrorType.connectTimeout:
        message = 'Connection timeout with the server';
        break;
      case DioErrorType.other:
        message =
            'Unexpected ERROR ! please let the admin check it: ${dioError.message}';
        break;
      case DioErrorType.response:
        message = _handleError(dioError.response!);
        break;
      case DioErrorType.sendTimeout:
        message = 'Send request in connection timeout with the server';
        break;
      default:
        message =
            'Unexpected ERROR ! please let the admin check it: ${dioError.message}';
        break;
    }
  }

  String _handleError(Response response) {
    print(response);
    String? _res;
    switch (response.statusCode) {
      case 400:
        _res = 'Bad request';
        break;
      case 401:
        _res = 'You are not authroized to use that ';
        break;
      case 404:
        _res = response.data['message'];
        break;
      case 500:
        _res = 'Internal server error';
        break;
      default:
        _res = 'Oops something went wrong, so unknown error';
        break;
    }
    return _res!;
  }

  @override
  String toString() => message!;
}
