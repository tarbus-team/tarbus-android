import 'package:tarbus_app/data/model/remote_departure.dart';
import 'package:tarbus_app/manager/api_manager.dart';
import 'package:xml/xml.dart';

abstract class MpkRepository {
  /// Throws [ErrorExceptions].
  Future<List<RemoteDeparture>> getLiveDepartures(int busStopId);
}

class RemoteMpkRepository extends MpkRepository {
  ApiManager _apiManager = ApiManager('http://rozklad.komunikacja.tarnow.pl/');

  @override
  Future<List<RemoteDeparture>> getLiveDepartures(int busStopId) async {
    final _response = await _apiManager.get(
      path: '/Home/GetTimetableReal',
      queryParameters: {"busStopId": busStopId},
    );
    if (_response.data != null && _response.data.isNotEmpty) {
      List<RemoteDeparture> root = XmlDocument.parse(_response.data)
          .firstElementChild!
          .firstElementChild!
          .firstElementChild!
          .findElements('R')
          .map<RemoteDeparture>(
            (e) => RemoteDeparture.fromElement(e),
          )
          .toList();
      print(root);
      return root;
    }
    return List.empty(growable: true);
  }
}
