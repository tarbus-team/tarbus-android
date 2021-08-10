class Company {
  int id;
  String name;

  Company({required this.id, required this.name});

  factory Company.fromJSON(Map<String, dynamic> json) {
    return Company(
      id: json['cpn_id'],
      name: json['cpn_name'],
    );
  }

  @override
  String toString() {
    return 'Company{id: $id, name: $name}';
  }
}
