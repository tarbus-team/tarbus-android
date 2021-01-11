class LastUpdated {
  int year;
  int month;
  int day;
  int hour;
  int min;

  LastUpdated({this.year, this.month, this.day, this.hour, this.min});

  bool equal(LastUpdated lastUpdated) {
    if (year == lastUpdated.year && month == lastUpdated.month && day == lastUpdated.day && hour == lastUpdated.hour && min == lastUpdated.min) {
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return '$day-$month-$year $hour:$min';
  }

  factory LastUpdated.fromJson(Map<String, dynamic> json) =>
      LastUpdated(year: json['year'], month: json['month'], day: json['day'], hour: json['hour'], min: json['min']);
}
