import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/views/home_view/home_view.dart';
import 'package:tarbus2021/src/views/splash_screen_view/controller/splash_screen_view_controller.dart';

class SplashScreenView extends StatefulWidget {
  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  SplashScreenViewController viewController = SplashScreenViewController();
  bool downloadError = false;
  bool downloadingStatus = false;

  @override
  void initState() {
    update();
    super.initState();
  }

  void update() async {
    viewController.scheduleStatus = await viewController.checkForUpdates();
    if (viewController.scheduleStatus == ScheduleStatus.noConnection) {
      setState(() {
        downloadError = true;
      });
      return;
    } else if (viewController.scheduleStatus == ScheduleStatus.old) {
      setState(() {
        downloadingStatus = true;
      });
    }
    if (await viewController.updateIfExpired()) {
      Navigator.of(context).pushReplacement(MaterialPageRoute<String>(builder: (context) => HomeView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      backgroundColor: AppColors.primaryColor,
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/logo_tarbus_main.svg",
              color: Colors.white,
              height: 200,
            ),
          ],
        ),
        _buildLoadBox(),
      ],
    );
  }

  Widget _buildLoadBox() {
    if (downloadingStatus) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: CircularProgressIndicator(),
          ),
          Text(
            "Trwa pobieranie nowego rozkładu jazdy",
            style: TextStyle(fontFamily: 'Asap', fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      );
    }
    if (downloadError) {
      return _buildConnectionError();
    }

    return Container(
      width: 0,
      height: 0,
    );
  }

  Widget _buildConnectionError() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Brak połączenia z internetem. Nie możemy sprawdzić czy rozkład jazdy jest aktualny! Możesz kontynuować lub spróbować ponownie',
            style: TextStyle(fontFamily: 'Asap', color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 30,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute<String>(builder: (context) => HomeView()));
            },
            child: Text("Kontynuuj"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute<String>(builder: (context) => SplashScreenView()));
            },
            child: Text("Sprawdź ponownie"),
          )
        ],
      ),
    );
  }
}
