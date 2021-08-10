import 'package:tarbus_app/data/model/schedule/company.dart';
import 'package:tarbus_app/manager/database.dart';

class CompanyDatabase {
  static const String COMPANIES_QUERY = 'SELECT * FROM Company cpn';

  static Future<List<Company>> getAllCompanies(
      {String name = '', int? limit}) async {
    String query = '$COMPANIES_QUERY WHERE cpn.cpn_name LIKE \'%$name%\'';
    if (limit != null) {
      query += ' LIMIT $limit';
    }
    final result = await DatabaseHelper.instance.doSQL(query);
    return result.map((e) => Company.fromJSON(e)).toList();
  }
}
