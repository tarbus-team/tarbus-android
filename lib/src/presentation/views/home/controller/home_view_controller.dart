import 'package:tarbus2021/src/model/database/database_helper.dart';

class HomeViewController {
  void addDialogToList(var id) {
    DatabaseHelper.instance.addDialogToList(id);
  }
}
