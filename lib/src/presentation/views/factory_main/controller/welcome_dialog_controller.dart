import 'package:tarbus2021/src/app/app_consts.dart';
import 'package:tarbus2021/src/utils/shared_preferences_utils.dart';

class WelcomeDialogController {
  void addDialogToList(int id) {
    SharedPreferencesUtils.add(AppConsts.SharedPreferencesDialog, id.toString());
  }
}
