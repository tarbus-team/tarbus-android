import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClearButton extends StatelessWidget {
  final button;

  const ClearButton({Key key, this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(padding: EdgeInsets.zero, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, minWidth: 0, height: 0, child: button);
  }
}
