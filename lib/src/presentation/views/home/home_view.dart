import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/model/entity/bus_line.dart';
import 'package:tarbus2021/src/model/entity/favourite_bus_stop.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/appbar_title.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/favourites_edit_bus_stop_dialog.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/snackbar_button.dart';
import 'package:tarbus2021/src/presentation/views/bus_routes/bus_routes_view.dart';
import 'package:tarbus2021/src/presentation/views/home/controller/home_view_controller.dart';
import 'package:tarbus2021/src/presentation/views/schedule/factory_schedule_view.dart';
import 'package:tarbus2021/src/presentation/views/search/search_bus_line_view.dart';
import 'package:tarbus2021/src/presentation/views/search/search_bus_stop_view.dart';
import 'package:tarbus2021/src/utils/favourites_bus_line_utils.dart';
import 'package:tarbus2021/src/utils/favourites_bus_stop_utils.dart';

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
              title: 'Ulubione linie autobusowe',
              actionName: 'Dodaj',
              action: () async {
                final trigger = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchBusLineView(showFavouritesButton: true),
                  ),
                );
                setState(() {});
              },
            ),
            _buildFavBusLineList(),
            HeaderTitle(
              title: 'Ulubione przystanki',
              actionName: 'Dodaj',
              action: () async {
                final trigger = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchBusStopView(showFavouritesButton: true),
                  ),
                );
                setState(() {});
              },
            ),
            _buildFavBusStopList(),
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

  Widget _buildFavBusStopList() {
    return FutureBuilder<List<FavouriteBusStop>>(
      future: viewController.getFavouritesBusStops(),
      builder: (BuildContext context, AsyncSnapshot<List<FavouriteBusStop>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var favBusStop = snapshot.data[index];
              List choices = [
                CustomPopupMenu(
                  title: 'Usuń',
                  icon: Icons.delete_outline,
                  action: () {
                    FavouritesBusStopUtils.removeFavouriteBusStop(favBusStop.busStop.id.toString());
                  },
                ),
                CustomPopupMenu(
                  title: 'Edytuj',
                  icon: Icons.edit,
                  action: () async {
                    var operationStatus = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavouritesEditBusStopDialog(busStop: favBusStop.busStop, oldName: favBusStop.name),
                      ),
                    );
                    if (operationStatus) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Pomyślnie zedytowano!'),
                        ),
                      );
                      setState(() {});
                    }
                  },
                ),
              ];

              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushNamed(FactoryScheduleView.route, arguments: favBusStop.busStop);
                  },
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset('assets/icons/icon_bus_stop.svg', width: 25, height: 25),
                    ],
                  ),
                  title: Text(favBusStop.name),
                  subtitle: Text(favBusStop.busStop.name),
                  trailing: PopupMenuButton(
                    elevation: 3.2,
                    onSelected: (value) {
                      value.action();
                    },
                    itemBuilder: (BuildContext context) {
                      return choices.map((choice) {
                        return PopupMenuItem(
                          height: 20.0,
                          value: choice,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                              choice.action();
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                Icon(choice.icon),
                                Container(
                                  width: 10,
                                ),
                                Text(choice.title),
                              ],
                            ),
                          ),
                        );
                      }).toList();
                    },
                    child: Icon(Icons.more_vert),
                  ),
                ),
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
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var busLine = snapshot.data[index];
              List choices = [
                CustomPopupMenu(
                    title: 'Usuń',
                    icon: Icons.delete_outline,
                    action: () {
                      FavouritesBusLineUtils.removeFavouriteBusLine(busLine.id.toString());
                    }),
              ];
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) {
                          return BusRoutesView(busLine: busLine);
                        },
                        transitionsBuilder: (context, animation1, animation2, child) {
                          return FadeTransition(
                            opacity: animation1,
                            child: child,
                          );
                        },
                        transitionDuration: Duration(milliseconds: 150),
                      ),
                    );
                  },
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset('assets/icons/icon_bus.svg', width: 25, height: 25),
                    ],
                  ),
                  title: Text(busLine.name),
                  subtitle: Text('Michalus'),
                  trailing: PopupMenuButton(
                    elevation: 3.2,
                    onSelected: (value) {
                      value.action();
                    },
                    itemBuilder: (BuildContext context) {
                      return choices.map((choice) {
                        return PopupMenuItem(
                          height: 20.0,
                          value: choice,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                              choice.action();
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                Icon(choice.icon),
                                Container(
                                  width: 10,
                                ),
                                Text(choice.title),
                              ],
                            ),
                          ),
                        );
                      }).toList();
                    },
                    child: Icon(Icons.more_vert),
                  ),
                ),
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

class CustomPopupMenu {
  CustomPopupMenu({this.title, this.icon, this.action});

  String title;
  IconData icon;
  Function action;
}
