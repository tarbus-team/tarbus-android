import 'package:tarbus2021/config/config.dart';

class ConfigStorage {
  static final ConfigStorage _singleton = ConfigStorage._internal();

  AppConfig config;

  factory ConfigStorage() {
    return _singleton;
  }

  ConfigStorage._internal();

  void init(AppConfig config) {
    this.config = config;
  }
}
