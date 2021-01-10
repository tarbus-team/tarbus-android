import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/app/widgets/horizontal_line.dart';
import 'package:tarbus2021/src/views/app_info_view/app_info_view.dart';
import 'package:tarbus2021/src/views/bus_lines_view/bus_lines_view.dart';
import 'package:tarbus2021/src/views/home_view/controller/home_view_controller.dart';
import 'package:tarbus2021/src/views/search_view/search_view.dart';

import 'home_button.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewController viewController = HomeViewController();

  @override
  void initState() {
    update();
    super.initState();
  }

  void update() async {
    viewController.getLastUpdateDate();
    viewController.jsonMessage = await viewController.getMessageFromTarbus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String updateTime = viewController.lastUpdated != null ? viewController.lastUpdated.toString() : '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Rozkład jazdy Gminnej Komunikacji Publicznej'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: AppDimens.margin_view_horizontally),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/logo_tarbus_menu.png'),
                  height: 80,
                ),
              ],
            ),
            if (viewController.jsonMessage != null && viewController.jsonMessage.message != null) _buildMessageBox(),
            HorizontalLine(),
            HomeButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) => BusLinesView()));
              },
              title: 'Linie autobusowe',
              image: AssetImage("assets/icons/bus_b.png"),
            ),
            HomeButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) => SearchView()));
              },
              title: 'Szukaj przystanku',
              icon: Icons.search,
            ),
            HomeButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) => AppInfoView()));
              },
              title: 'Informacje o aplikacji',
              icon: Icons.info,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.margin_view_horizontally, vertical: 20),
                child: Text('Data ostatniej aktualizacji: $updateTime', style: TextStyle(fontFamily: 'Asap', fontSize: 12))),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBox() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  viewController.jsonMessage.message,
                  softWrap: true,
                )),
          ),
        ],
      ),
    );
  }
}
