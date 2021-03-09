import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_consts.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/model/entity/bus_line.dart';
import 'package:tarbus2021/src/model/entity/favourite_bus_stop.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/appbar_title.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/snackbar_button.dart';
import 'package:tarbus2021/src/presentation/views/home/controller/home_view_controller.dart';
import 'package:tarbus2021/src/presentation/views/home/fav_bus_line_list_item.dart';
import 'package:tarbus2021/src/presentation/views/search/search_bus_line_view.dart';
import 'package:tarbus2021/src/presentation/views/search/search_bus_stop_view.dart';
import 'package:tarbus2021/src/utils/web_page_utils.dart';

import 'fav_bus_stop_list_item.dart';
import 'header_title.dart';

class HomeView extends StatefulWidget {
  static const route = '/home';

  HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  HomeViewController viewController = HomeViewController();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [
            SnackbarButton(action: () {
              Scaffold.of(context).openDrawer();
            }),
            AppBarTitle(title: AppString.appInfoApplicationName)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTitle(
              title: AppString.labelFavBusLines,
              actionName: AppString.labelAdd,
              action: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => SearchBusLineView(showFavouritesButton: true),
                  ),
                );
                setState(() {});
              },
            ),
            _buildFavBusLineList(),
            HeaderTitle(
              title: AppString.labelFavBusStops,
              actionName: AppString.labelAdd,
              action: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => SearchBusStopView(showFavouritesButton: true),
                  ),
                );
                setState(() {});
              },
            ),
            _buildFavBusStopList(),
            HeaderTitle(title: AppString.labelCommunity),
            Card(
              margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/icons/fb_icon_rounded.png'),
                    ),
                  ],
                ),
                title: Text(AppString.labelWeAreOnFacebook),
                subtitle: Text(AppString.labelJoinUs),
                trailing: RaisedButton(
                  onPressed: () {
                    WebPageUtils.openURL(AppConsts.FACEBOOK_TARBUS);
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text(AppString.labelGo, style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavBusStopList() {
    return FutureBuilder<List<FavouriteBusStop>>(
      future: viewController.getFavouritesBusStops(),
      builder: (BuildContext context, AsyncSnapshot<List<FavouriteBusStop>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return SizedBox(
              height: 80.0,
              child: Center(
                child: Text(
                  AppString.labelEmptyFavStops,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var favBusStop = snapshot.data[index];
              return FavBusStopListItem(
                favBusStop: favBusStop,
                onUpdate: () {
                  setState(() {});
                },
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildFavBusLineList() {
    return FutureBuilder<List<BusLine>>(
      future: viewController.getFavouritesBusLines(),
      builder: (BuildContext context, AsyncSnapshot<List<BusLine>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return SizedBox(
              height: 80.0,
              child: Center(
                child: Text(
                  AppString.labelEmptyFavLines,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var favBusLine = snapshot.data[index];
              return FavBusLineListItem(
                favBusLine: favBusLine,
                onUpdate: () {
                  setState(() {});
                },
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
