class SingleDestination {
  String destination;

  SingleDestination({this.destination});

  factory SingleDestination.fromJson(Map<String, dynamic> json) => new SingleDestination(
        destination: json["destination_name"],
      );
}
