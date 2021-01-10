import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tarbus2021/src/model/json_message.dart';
import 'package:tarbus2021/src/model/last_updated.dart';
import 'package:tarbus2021/src/remote/json_holder.dart';

class JsonService {
  static Future<LastUpdated> getLastUpdateDate() async {
    final response = await http.get('https://dpajak99.github.io/tarbus-api/last-update2.json');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return LastUpdated.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  static Future<bool> getNewDatabase() async {
    final response = await http.get('https://dpajak99.github.io/tarbus-api/tarbus2.json');

    if (response.statusCode == 200) {
      return JsonHolder.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  static Future<JsonMessage> getMessageFromTarbus() async {
    final response = await http.get('https://dpajak99.github.io/tarbus-api/message.json');

    if (response.statusCode == 200) {
      return JsonMessage.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
