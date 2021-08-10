import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionTile extends StatelessWidget {
  final String title;

  const ActionTile({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 15),
      ),
      dense: true,
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 15,
      ),
    );
  }
}
