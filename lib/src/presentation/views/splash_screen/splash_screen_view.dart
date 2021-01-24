import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/presentation/views/home/home_view.dart';

import 'controller/splash_screen_view_controller.dart';

class SplashScreenView extends StatefulWidget {
  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  SplashScreenViewController viewController = SplashScreenViewController();
  bool isError = false;
  String errorMessage = "";
  bool downloadingStatus = false;

  @override
  void initState() {
    update();
    super.initState();
  }

  void update() async {
    var onlineStatus = await viewController.init();
    //TODO - If inside if insde if - if mess
    if (onlineStatus) {
      viewController.scheduleStatus = await viewController.checkForUpdates();
      if (viewController.scheduleStatus == ScheduleStatus.old) {
        setState(() {
          downloadingStatus = true;
        });
        if (await viewController.updateIfExpired()) {
          openHomeView();
        } else {
          setState(() {
            errorMessage = AppString.errorUnknown;
            isError = true;
          });
        }
      }
      openHomeView();
    } else {
      setState(() {
        errorMessage = AppString.errorNoInternetConnection;
        isError = true;
      });
    }
  }

  void openHomeView() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute<String>(builder: (context) => HomeView(appStartSettings: viewController.appStartSettings)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      backgroundColor: AppColors.primaryColor,
      floatingActionButton: Stack(
        children: [
          Positioned(
            left: 40,
            bottom: 40,
            child: FlatButton(
                onPressed: () async {
                  var status = viewController.setSettingsOffline();
                  openHomeView();
                },
                child: Text(
                  AppString.labelLaunchOffline,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                )),
          ),
        ],
      ),
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
            AppString.labelDownloadingSchedule,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      );
    }
    if (isError) {
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
            errorMessage,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 30,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute<String>(builder: (context) => HomeView()));
            },
            child: Text(AppString.labelContinue),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute<String>(builder: (context) => SplashScreenView()));
            },
            child: Text(AppString.labelCheckAgain),
          )
        ],
      ),
    );
  }
}
