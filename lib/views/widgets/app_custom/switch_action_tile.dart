import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SwitchActionTile extends StatefulWidget {
  final String title;
  final IconData? icon;
  final String? customIconPath;
  final bool isSelected;

  const SwitchActionTile(
      {Key? key,
      required this.title,
      this.icon,
      required this.isSelected,
      this.customIconPath})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SwitchActionTile();
}

class _SwitchActionTile extends State<SwitchActionTile> {
  late bool isSelected;

  @override
  void initState() {
    isSelected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 1,
          color: Colors.grey.shade300,
        ))),
        child: ListTile(
            leading: widget.icon != null
                ? Icon(widget.icon)
                : widget.customIconPath != null
                    ? SvgPicture.asset(widget.customIconPath!)
                    : null,
            title: Text(
              widget.title,
              style: TextStyle(fontSize: 15),
            ),
            dense: true,
            trailing: Switch(
              onChanged: (value) {
                setState(() {
                  isSelected = !isSelected;
                });
              },
              value: isSelected,
            )));
  }
}
