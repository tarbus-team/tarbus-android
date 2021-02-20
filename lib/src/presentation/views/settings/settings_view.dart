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
  String lastUpdatedDate = '---';

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
          children: [AppBarTitle(title: AppString.labelSettings)],
        ),
      ),
      body: Column(
        children: [
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
