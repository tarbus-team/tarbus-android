class AvailableVersionModel {
  String companyName;
  String subscribeCode;
  int? validationDate;
  String? avatarSrc;

  AvailableVersionModel(
      {this.companyName = '-',
      this.subscribeCode = '-',
      this.validationDate,
      this.avatarSrc});

  factory AvailableVersionModel.fromJSON(json) {
    return AvailableVersionModel(
      companyName: json['company_name'],
      subscribeCode: json['subscribe_code'],
      validationDate: json['validation_date'],
      avatarSrc: json['avatar_src'],
    );
  }
}
