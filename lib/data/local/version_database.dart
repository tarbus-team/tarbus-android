import 'package:tarbus_app/data/model/schedule/version.dart';
import 'package:tarbus_app/manager/database.dart';

class VersionDatabase {
  static const String VERSION_QUERY =
      'SELECT * FROM Versions v JOIN Company cpn ON v.v_company_id = cpn.cpn_id ';

  static Future<Version> getVersionBySubscribeCode(String subscribeCode) async {
    String query =
        '$VERSION_QUERY WHERE v.v_subscribe_code LIKE \'$subscribeCode\'';
    final result = await DatabaseHelper.instance.doSQL(query);
    if (result.length > 0) {
      return Version.fromJSON(result.first);
    } else {
      throw Exception('Cannot find version');
    }
  }
}
