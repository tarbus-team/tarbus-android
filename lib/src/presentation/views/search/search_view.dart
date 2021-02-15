import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/appbar_title.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/snackbar_button.dart';
import 'package:tarbus2021/src/presentation/views/home/header_title.dart';
import 'package:tarbus2021/src/presentation/views/search/search_bus_line_view.dart';
import 'package:tarbus2021/src/presentation/views/search/search_bus_stop_view.dart';

class SearchView extends StatefulWidget {
  static const route = '/search';

  @override
  _SearchBusStopViewState createState() => _SearchBusStopViewState();
}

class _SearchBusStopViewState extends State<SearchView> {
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
            AppBarTitle(title: AppString.labelSearch)
          ],
        ),
      ),
      body: Column(
        children: [
          HeaderTitle(
            title: 'Wyszukaj',
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchBusStopView(),
                  ),
                );
              },
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.search_outlined, color: AppColors.instance(context).iconColor),
                ],
              ),
              title: Text('Wyszukaj przystanki'),
              subtitle: Text('Kliknij aby wyszukać'),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchBusLineView(),
                  ),
                );
              },
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.search_outlined,
                    color: AppColors.instance(context).iconColor,
                  ),
                ],
              ),
              title: Text('Wyszukaj linie autobusowe'),
              subtitle: Text('Kliknij aby wyszukać'),
            ),
          ),
        ],
      ),
    );
  }
}
