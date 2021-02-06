import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/model/entity/bus_line.dart';
import 'package:tarbus2021/src/model/entity/favourite_bus_stop.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/appbar_title.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/snackbar_button.dart';
import 'package:tarbus2021/src/presentation/views/home/controller/home_view_controller.dart';

import 'header_title.dart';

class HomeView extends StatefulWidget {
  static const route = '/home';

  HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewController viewController = HomeViewController();

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
              title: 'Ulubione linie autobusowe',
              actionName: 'Dodaj',
            ),
            FutureBuilder<List<BusLine>>(
              future: viewController.getFavouritesBusLines(),
              builder: (BuildContext context, AsyncSnapshot<List<BusLine>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var busLine = snapshot.data[index];
                      return Card(
                        child: ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset('assets/icons/icon_bus.svg', width: 25, height: 25),
                            ],
                          ),
                          title: Text(busLine.name),
                          subtitle: Text('Michalus'),
                          trailing: Icon(Icons.more_vert),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            HeaderTitle(
              title: 'Ulubione przystanki',
              actionName: 'Dodaj',
            ),
            FutureBuilder<List<FavouriteBusStop>>(
              future: viewController.getFavouritesBusStops(),
              builder: (BuildContext context, AsyncSnapshot<List<FavouriteBusStop>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var favBusStop = snapshot.data[index];
                      return Card(
                        child: ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset('assets/icons/icon_bus_stop.svg', width: 25, height: 25),
                            ],
                          ),
                          title: Text(favBusStop.name),
                          subtitle: Text(favBusStop.busStop.name),
                          trailing: Icon(Icons.more_vert),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            HeaderTitle(title: 'Społeczność'),
            Card(
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/icons/fb_icon_rounded.png'),
                    ),
                  ],
                ),
                title: Text('Jesteśmy na Facebooku'),
                subtitle: Text('Dołącz do nas'),
                trailing: RaisedButton(
                  onPressed: () {},
                  color: AppColors.primaryColor,
                  child: Text('Przejdź', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
