import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarbus2021/app/app_string.dart';
import 'package:tarbus2021/model/database/database_helper.dart';
import 'package:tarbus2021/presentation/custom_widgets/appbar_title.dart';
import 'package:tarbus2021/presentation/custom_widgets/horizontal_line.dart';
import 'package:tarbus2021/presentation/views/about_us/about_us_view.dart';
import 'package:tarbus2021/presentation/views/policy_privacy/policy_privacy_view.dart';
import 'package:tarbus2021/utils/theme_provider.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String lastUpdatedDate = '---';
  bool isDark = false;

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
    var _themeProvider = Provider.of<MyTheme>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [AppBarTitle(title: AppString.labelSettings)],
        ),
      ),
      body: Column(
        children: [
          HorizontalLine(),
          ListTile(
            title: Text('Tryb ciemny'),
            subtitle: Text('Uwaga, ta opcja nadpisuje tryb systemowy'),
            trailing: Switch(
              value: MyTheme.isDark,
              onChanged: (bool value) {
                _themeProvider.changeTheme();
              },
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) => PolicyPrivacyView()));
            },
          ),
          HorizontalLine(),
          ListTile(
            title: Text(AppString.labelPrivacyPolicy),
            subtitle: Text(AppString.labelPrivacyPolicy),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) => PolicyPrivacyView()));
            },
          ),
          HorizontalLine(),
          ListTile(
            title: Text(AppString.labelDatabase),
            subtitle: Text('${AppString.labelLastUpdated}: $lastUpdatedDate'),
          ),
          HorizontalLine(),
          ListTile(
            title: Text('${AppString.labelInfoAboutApp} ${AppString.appInfoApplicationName}'),
            subtitle: Text('${AppString.labelVersion} ${AppString.appInfoVersion}'),
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
