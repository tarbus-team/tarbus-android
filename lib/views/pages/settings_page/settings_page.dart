import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/views/pages/settings_page/theme_mode_sheet.dart';
import 'package:tarbus_app/views/widgets/app_bars/custom_app_bar.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Ustawienia',
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (_) => ThemeModeSheet(),
              );
            },
            child: ListTile(
              title: Text('Tryb ciemny'),
            ),
          ),
        ],
      ),
    );
  }
}
