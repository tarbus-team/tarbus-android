import 'package:tarbus2021/app/app_consts.dart';
import 'package:tarbus2021/utils/shared_preferences_utils.dart';

class WelcomeDialogController {
  void addDialogToList(int id) {
    SharedPreferencesUtils.add(AppConsts.SharedPreferencesDialog, id.toString());
  }
}
