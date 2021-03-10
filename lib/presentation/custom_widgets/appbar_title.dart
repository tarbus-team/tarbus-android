import 'package:flutter/cupertino.dart';

class AppBarTitle extends StatelessWidget {
  final String title;

  const AppBarTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.clip,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      ),
    );
  }
}
