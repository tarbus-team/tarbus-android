import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/app_circular_progress_Indicator.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/nothing.dart';

import 'controller/splash_screen_view_controller.dart';

class SplashScreenView extends StatefulWidget {
  static const route = '/splash';

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  SplashScreenViewController viewController = SplashScreenViewController();
  bool isError;
  String errorMessage;
  bool downloadingStatus;

  @override
  void initState() {
    update();
    super.initState();
  }

  void update() async {
    isError = false;
    errorMessage = "";
    downloadingStatus = false;

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
    Navigator.of(context).pushReplacementNamed('/start', arguments: viewController.settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: Stack(
        children: [
          if (!downloadingStatus)
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
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.instance(context).mainFontColor),
                ),
              ),
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
              color: AppColors.instance(context).tommorowLabelColor,
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
            child: AppCircularProgressIndicator(),
          ),
          Text(
            AppString.labelDownloadingSchedule,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.instance(context).mainFontColor),
          )
        ],
      );
    }
    if (isError) {
      return _buildConnectionError();
    }

    return Nothing();
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
            style: TextStyle(color: AppColors.instance(context).mainFontColor, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 30,
          ),
          RaisedButton(
            onPressed: () {
              openHomeView();
            },
            child: Text(AppString.labelContinue),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                update();
              });
            },
            child: Text(AppString.labelCheckAgain),
          )
        ],
      ),
    );
  }
}
