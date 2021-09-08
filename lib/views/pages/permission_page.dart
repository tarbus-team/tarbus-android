import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tarbus_app/shared/location_controller.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';
import 'package:tarbus_app/views/widgets/app_bars/custom_app_bar.dart';

class PermissionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PermissionPage();
}

class _PermissionPage extends State<PermissionPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await context.router.replace(AppRoute());
    }
  }

  Future<void> runPermissionAnswer() async {
    await checkPermissions();
    await LocationController.askForPermissions();
    await checkPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Lokalizacja',
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/gps_image.svg',
                width: MediaQuery.of(context).size.width * 0.60,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Potrzebujemy dostępu do\n Twojej lokalizacji',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 19),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text('Dlaczego o to pytamy?')),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                  onPressed: runPermissionAnswer,
                  child: Text('Udziel pozwolenia')),
            ],
          ),
        ),
      ),
    );
  }
}
