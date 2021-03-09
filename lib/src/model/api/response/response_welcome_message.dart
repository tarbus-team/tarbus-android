import 'package:tarbus2021/src/app/app_string.dart';

class ResponseWelcomeMessage {
  String message = '';
  String href = '';

  ResponseWelcomeMessage({this.message, this.href});

  ResponseWelcomeMessage.offline() {
    message = AppString.labelOfflineMode;
  }

  factory ResponseWelcomeMessage.fromJson(Map<String, dynamic> json) =>
      ResponseWelcomeMessage(message: json['message'] as String, href: json['href'] as String);
}
