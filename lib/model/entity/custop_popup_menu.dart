import 'package:flutter/cupertino.dart';

class CustomPopupMenu {
  CustomPopupMenu({this.title, this.icon, this.action});

  String title;
  IconData icon;
  Function action;
}
