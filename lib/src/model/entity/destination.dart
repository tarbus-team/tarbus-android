class Destination {
  int id;
  int routeId;
  String symbol;
  String directionBoardName;
  String scheduleName;

  Destination({this.id, this.routeId, this.symbol, this.directionBoardName, this.scheduleName});

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        id: json['ds_id'] as int,
        routeId: json['ds_route_id'] as int,
        symbol: json['ds_symbol'] as String,
        directionBoardName: json['ds_direction_board_name'] as String,
        //TODO: Literówka - schedule a nie shedule
        scheduleName: json['ds_shedule_name'] as String,
      );

  @override
  String toString() {
    return 'Destination{id: $id, routeId: $routeId, symbol: $symbol, directionBoardName: $directionBoardName, scheduleName: $scheduleName}';
  }
}
