import 'package:hive/hive.dart';

import 'storage_model/subscribed_version_model.dart';

class SubscribedScheduleStorage {
  static Future<List<SubscribedVersionModel>> getSubscribedVersions() async {
    final box =
        await Hive.openBox<SubscribedVersionModel>('subscribed_versions');
    final result = box.values.toList();
    await box.close();
    return result;
  }

  static Future<void> updateSubscribedVersions(
      List<SubscribedVersionModel> data) async {
    final box =
        await Hive.openBox<SubscribedVersionModel>('subscribed_versions');
    await box.clear();
    await box.addAll(data);
  }
}
