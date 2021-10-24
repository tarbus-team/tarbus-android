import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/config/app_colors.dart';

class ActionTile extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function? onTap;
  final bool isLast;

  const ActionTile({
    Key? key,
    required this.title,
    this.icon,
    this.onTap,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        decoration: !isLast
            ? BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                width: 1,
                color: AppColors.of(context).breakpoint,
              )))
            : null,
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
