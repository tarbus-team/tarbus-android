import 'package:tarbus_app/data/model/available_version_model.dart';

class AvailableVersionsResponse {
  String? note;
  List<AvailableVersionModel>? availableVersions;

  AvailableVersionsResponse({
    this.note,
    this.availableVersions,
  });

  factory AvailableVersionsResponse.fromJSON(json) {
    return AvailableVersionsResponse(
      note: json['note'],
      availableVersions: List<AvailableVersionModel>.from(json['versions']
          .map((model) => AvailableVersionModel.fromJSON(model))),
    );
  }
}
