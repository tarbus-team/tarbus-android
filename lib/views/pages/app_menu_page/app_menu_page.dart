import 'package:flutter/cupertino.dart';
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
      body: Text('Menu'),
    );
  }
}
