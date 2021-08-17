import 'package:geolocator/geolocator.dart';

class LocationController {
  LocationController();

  static Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  static Future<bool> canGetPosition() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if ((locationPermission == LocationPermission.whileInUse ||
            locationPermission == LocationPermission.always) &&
        isServiceEnabled) {
      return true;
    }
    return false;
  }

  static Future<LocationPermission> askForPermissions() async {
    LocationPermission permission = await Geolocator.requestPermission();
    print(permission);
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      if (await Geolocator.openLocationSettings()) {
        await Geolocator.openAppSettings();
      }
    }
    return await Geolocator.checkPermission();
  }

  Future<Position?> getPosition() async {
    Position? position;
    if (await Geolocator.isLocationServiceEnabled()) {
      position = await Geolocator.getCurrentPosition();
    } else {
      position = await Geolocator.getLastKnownPosition();
    }
    return position;
  }
}
