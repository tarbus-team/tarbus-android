import 'package:flutter/material.dart';

class BottomNavigationObject {
  int index;
  Widget route;
  BottomNavigationBarItem item;

  BottomNavigationObject({@required this.index, @required this.route, @required this.item});
}
