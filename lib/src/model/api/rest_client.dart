import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tarbus2021/src/model/api/response/response_last_updated.dart';
import 'package:tarbus2021/src/model/api/response/response_welcome_dialog.dart';
import 'package:tarbus2021/src/model/api/response/response_welcome_message.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://dpajak99.github.io/tarbus-api/v2-1-1/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/last-update.json")
  Future<ResponseLastUpdated> getLastUpdateDate();

  @GET("/database.json")
  Future<String> getNewDatabase();

  @GET("/message.json")
  Future<ResponseWelcomeMessage> getWelcomeMessage();

  @GET("/alert-dialog.json")
  Future<ResponseWelcomeDialog> getAlertDialog();
}
