import 'package:tarbus_app/config/locator.dart';
import 'package:tarbus_app/data/model/remote_departure.dart';
import 'package:tarbus_app/manager/api.dart';
import 'package:xml/xml.dart';

abstract class MpkRepository {
  /// Throws [ErrorExceptions].
  Future<List<RemoteDeparture>> getLiveDepartures(int busStopId);
}

class RemoteMpkRepository extends MpkRepository {
  @override
  Future<List<RemoteDeparture>> getLiveDepartures(int busStopId) async {
    final _response = await getIt<API>().get(
      host: 'http://rozklad.komunikacja.tarnow.pl/',
      path: '/Home/GetTimetableReal',
      queryParam: {"busStopId": busStopId},
      header: {},
    );
    print("RESPONSE $_response");
    if (_response != null && _response.isNotEmpty) {
      List<RemoteDeparture> root = XmlDocument.parse(_response)
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
