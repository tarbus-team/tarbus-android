import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionTile extends StatelessWidget {
  final String title;
  final IconData? icon;

  const ActionTile({
    Key? key,
    required this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 1,
          color: Colors.grey.shade200,
        ))),
        child: ListTile(
          leading: icon != null ? Icon(icon) : null,
          title: Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
          dense: true,
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 15,
          ),
        ),
      ),
    );
  }
}
