import 'package:auto_route/auto_route.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tarbus_app/shared/location_controller.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';

class GpsGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    LocationPermission permission = await LocationController.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      resolver.next(true);
    } else {
      router.root.navigate(PermissionsRoute(), onFailure: (err) {
        print('Guard Error => $err');
      });
      resolver.next(false);
    }
  }
}
