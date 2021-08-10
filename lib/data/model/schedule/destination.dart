class Destination {
  int routeId;
  String symbol;
  String directionBoardName;
  String scheduleName;

  Destination({
    required this.routeId,
    required this.symbol,
    required this.directionBoardName,
    required this.scheduleName,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      routeId: json['ds_route_id'] as int,
      symbol: json['ds_symbol'] as String,
      directionBoardName: json['ds_direction_board_name'] as String,
      scheduleName: json['ds_shedule_name'] as String,
    );
  }

  @override
  String toString() {
    return 'Destination{ routeId: $routeId, symbol: $symbol, directionBoardName: $directionBoardName, scheduleName: $scheduleName}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Destination &&
          runtimeType == other.runtimeType &&
          routeId == other.routeId &&
          symbol == other.symbol;

  @override
  int get hashCode => routeId.hashCode ^ symbol.hashCode;
}
