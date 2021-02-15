import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/model/database/database_helper.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/appbar_title.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/horizontal_line.dart';
import 'package:tarbus2021/src/presentation/views/about_us/about_us_view.dart';
import 'package:tarbus2021/src/presentation/views/policy_privacy/policy_privacy_view.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  var lastUpdatedDate = '---';

  @override
  void initState() {
    super.initState();
    update();
  }

  void update() async {
    var tmp = await DatabaseHelper.instance.getLastSavedUpdateDate();
    lastUpdatedDate = tmp.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [AppBarTitle(title: 'Ustawienia')],
        ),
      ),
      body: Column(
        children: [
          HorizontalLine(),
          ListTile(
            title: Text('Polityka prywatności'),
            subtitle: Text('Polityka prywatności'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) => PolicyPrivacyView()));
            },
          ),
          HorizontalLine(),
          ListTile(
            title: Text('Baza danych'),
            subtitle: Text('Ostatnia aktualizacja: $lastUpdatedDate'),
          ),
          HorizontalLine(),
          ListTile(
            title: Text('Informacje o aplikacji tarBUS'),
            subtitle: Text('Wersja ${AppString.appInfoVersion}'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) => AboutUsView()));
            },
          ),
          HorizontalLine(),
        ],
      ),
    );
  }
}
