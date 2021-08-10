class Calendar {
  String date;
  String dayTypes;

  Calendar({required this.date, required this.dayTypes});

  factory Calendar.fromJSON(Map<String, dynamic> json) {
    return Calendar(
      date: json['c_date'],
      dayTypes: json['c_day_types'],
    );
  }

  @override
  String toString() {
    return 'Calendar{date: $date, dayTypes: $dayTypes}';
  }
}
