import 'package:hive/hive.dart';

import 'storage_model/subscribed_version_model.dart';

class SubscribedScheduleStorage {
  static List<SubscribedVersionModel> getSubscribedVersions() {
    final box = Hive.box<SubscribedVersionModel>('subscribed_versions');
    final result = box.values.toList();
    return result;
  }

  static Future<void> updateSubscribedVersions(
      List<SubscribedVersionModel> data) async {
    final box = Hive.box<SubscribedVersionModel>('subscribed_versions');
    await box.clear();
    await box.addAll(data);
  }
}
