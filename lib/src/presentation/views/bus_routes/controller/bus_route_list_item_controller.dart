class BusRouteListItemController {
  String getBusStopIconPath(int index, int arrayLength) {
    String iconPath;
    if (index == 0) {
      iconPath = 'assets/icons/first_bus_stop_icon_b.png';
    } else if (index == arrayLength - 1) {
      iconPath = 'assets/icons/last_bus_stop_icon_b.png';
    } else {
      iconPath = 'assets/icons/next_bus_stop_icon_b.png';
    }
    return iconPath;
  }
}
