class Destination {
  int id;
  int routeId;
  String symbol;
  String directionBoardName;
  String scheduleName;

  Destination({this.id, this.routeId, this.symbol, this.directionBoardName, this.scheduleName});

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        id: json['ds_id'],
        routeId: json['ds_route_id'],
        symbol: json['ds_symbol'],
        directionBoardName: json['ds_direction_board_name'],
        //TODO: Literówka - schedule a nie shedule
        scheduleName: json['ds_shedule_name'],
      );

  @override
  String toString() {
    return 'Destination{id: $id, routeId: $routeId, symbol: $symbol, directionBoardName: $directionBoardName, scheduleName: $scheduleName}';
  }
}
