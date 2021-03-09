class ResponseLastUpdated {
  int year;
  int month;
  int day;
  int hour;
  int min;

  ResponseLastUpdated({this.year, this.month, this.day, this.hour, this.min});

  bool equal(ResponseLastUpdated lastUpdated) {
    if (year == lastUpdated.year && month == lastUpdated.month && day == lastUpdated.day && hour == lastUpdated.hour && min == lastUpdated.min) {
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return '$day-$month-$year $hour:$min';
  }

  factory ResponseLastUpdated.fromJson(Map<String, dynamic> json) =>
      ResponseLastUpdated(year: json['year'], month: json['month'], day: json['day'], hour: json['hour'], min: json['min']);
}
