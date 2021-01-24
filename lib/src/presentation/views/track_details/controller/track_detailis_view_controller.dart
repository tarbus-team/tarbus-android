class TrackDetailsViewController {
  int index;
  int currentIndex;
  bool isCurrent = false;

  TrackDetailsViewController(this.index, this.currentIndex);

  void checkIfCurrentBusStop() {
    if (currentIndex != -2 && index == currentIndex) {
      isCurrent = true;
    }
  }

  String getTrackIconPath() {
    String iconPath;

    var status = isCurrent ? 'b' : 'g';
    if (index == 0) {
      iconPath = 'assets/icons/first_bus_stop_icon_$status.png';
    } else if (index == -1) {
      iconPath = 'assets/icons/last_bus_stop_icon_$status.png';
    } else {
      if (currentIndex != -2 && index >= currentIndex) {
        iconPath = 'assets/icons/next_bus_stop_icon_$status.png';
      } else {
        iconPath = 'assets/icons/next_bus_stop_icon_g_0.png';
      }
    }
    return iconPath;
  }
}
