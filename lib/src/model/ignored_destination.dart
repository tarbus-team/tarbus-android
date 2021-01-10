class IgnoredDestination {
  int ignoredDestinationId;
  int parentDestinationId;

  IgnoredDestination({this.ignoredDestinationId, this.parentDestinationId});

  factory IgnoredDestination.fromJson(Map<String, dynamic> json) => IgnoredDestination(
        ignoredDestinationId: json['ignored_destination_id'],
        parentDestinationId: json['parent_destination_id'],
      );
}
