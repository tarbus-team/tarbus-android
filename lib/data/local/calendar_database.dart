import 'package:tarbus_app/data/model/schedule/calendar.dart';
import 'package:tarbus_app/manager/database.dart';

class CalendarDatabase {
  static const String CALENDAR_QUERY = 'SELECT * FROM Calendar c';

  static Future<List<Calendar>> getCurrentDays(String timestamp) async {
    String query = '$CALENDAR_QUERY WHERE c.c_date LIKE \'$timestamp\'';
    final result = await DatabaseHelper.instance.doSQL(query);
    return result.map((e) => Calendar.fromJSON(e)).toList();
  }
}
