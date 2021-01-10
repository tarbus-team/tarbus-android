class SingleDestination {
  String destination;

  SingleDestination({this.destination});

  factory SingleDestination.fromJson(Map<String, dynamic> json) => SingleDestination(
        destination: json['destination_name'],
      );
}
