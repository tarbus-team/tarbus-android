import 'package:tarbus2021/src/database/database_helper.dart';
import 'package:tarbus2021/src/model/json_message.dart';
import 'package:tarbus2021/src/model/last_updated.dart';
import 'package:tarbus2021/src/remote/json_service.dart';
import 'package:tarbus2021/src/services/app_internet.dart';

class HomeViewController {
  LastUpdated lastUpdated;
  JsonMessage jsonMessage;

  HomeViewController() {
    jsonMessage = JsonMessage(message: '');
  }

  void getLastUpdateDate() async {
    LastUpdated localLastUpdate = await DatabaseHelper.instance.getLastSavedUpdateDate();
    lastUpdated = localLastUpdate;
  }

  Future<JsonMessage> getMessageFromTarbus() async {
    if (!await AppInternet.checkInternetStatus()) {
      return jsonMessage;
    }

    JsonMessage message = await JsonService.getMessageFromTarbus();
    return message;
  }
}
