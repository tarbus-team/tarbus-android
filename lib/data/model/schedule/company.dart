import 'dart:convert';

class Company {
  int id;
  String name;
  String avatar;
  String phone;
  String email;
  String website;
  String businessCardText;

  Company({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.website,
    required this.avatar,
    required this.businessCardText,
  });

  Map<String, dynamic> get businessCard => jsonDecode(businessCardText);

  factory Company.fromJSON(Map<String, dynamic> json) {
    return Company(
      id: json['cpn_id'],
      name: json['cpn_name'],
      phone: json['cpn_phone'],
      email: json['cpn_email'],
      website: json['cpn_website'],
      avatar: json['cpn_avatar'],
      businessCardText: json['cpn_business_card'],
    );
  }

  @override
  String toString() {
    return 'Company{id: $id, name: $name}';
  }
}
