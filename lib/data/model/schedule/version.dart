import 'package:tarbus_app/data/model/schedule/company.dart';

class Version {
  int id;
  String validationTimestamp;
  Company company;

  Version(
      {required this.id,
      required this.validationTimestamp,
      required this.company});

  factory Version.fromJSON(Map<String, dynamic> json) {
    return Version(
      id: json['v_id'],
      validationTimestamp: json['v_date'],
      company: Company.fromJSON(json),
    );
  }
}
