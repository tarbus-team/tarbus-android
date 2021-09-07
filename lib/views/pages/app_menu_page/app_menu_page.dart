import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';
import 'package:tarbus_app/views/widgets/app_custom/action_tile.dart';
import 'package:tarbus_app/views/widgets/app_custom/custom_card.dart';
import 'package:tarbus_app/views/widgets/generic/pretty_scroll_view.dart';

class AppMenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppMenuPage();
}

class _AppMenuPage extends State<AppMenuPage> {
  @override
  Widget build(BuildContext context) {
    return PrettyScrollView(
      subTitle: null,
      title: 'Menu',
      body: Column(
        children: [
          CustomCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'MENU',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                ActionTile(
                  icon: Icons.settings,
                  title: 'Ustawienia',
                  onTap: () {
                    context.router.root.navigate(SettingsRoute());
                  },
                ),
                ActionTile(
                    icon: Icons.build_circle_outlined,
                    title: 'Zmień przewoźników'),
              ],
            ),
          ),
          CustomCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'APLIKACJA',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                ActionTile(
                    icon: Icons.bug_report_outlined, title: 'Zgłoś błąd'),
                ActionTile(icon: Icons.messenger_outline, title: 'Feedback'),
                ActionTile(title: 'O aplikacji'),
                ActionTile(title: 'Polityka prywatności'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
