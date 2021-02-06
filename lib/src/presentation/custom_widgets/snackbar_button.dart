import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackbarButton extends StatelessWidget {
  final action;

  const SnackbarButton({Key key, this.action}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: ButtonTheme(
        padding: EdgeInsets.all(0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minWidth: 0,
        height: 0,
        child: FlatButton(
          onPressed: action,
          child: Icon(Icons.menu),
        ),
      ),
    );
  }
}
