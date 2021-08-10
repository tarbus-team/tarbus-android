import 'package:hive/hive.dart';
import 'package:tarbus_app/data/model/available_version_model.dart';

part 'subscribed_version_model.g.dart';

@HiveType(typeId: 0)
class SubscribedVersionModel {
  @HiveField(0)
  String? subscribeCode;
  @HiveField(1)
  int? updateDate;

  SubscribedVersionModel({
    this.subscribeCode,
    this.updateDate,
  });

  factory SubscribedVersionModel.fromAvailableVersion(
      AvailableVersionModel versionModel) {
    return SubscribedVersionModel(
      subscribeCode: versionModel.subscribeCode,
      updateDate: 0,
    );
  }
}
