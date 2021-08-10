import 'package:flutter/cupertino.dart';
import 'package:tarbus_app/views/widgets/generic/pretty_scroll_view.dart';

class AppSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppSearchPage();
}

class _AppSearchPage extends State<AppSearchPage> {
  @override
  Widget build(BuildContext context) {
    return PrettyScrollView(
      subTitle: null,
      title: 'Szukaj',
      body: Text('Szukaj'),
    );
  }
}
