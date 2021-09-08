import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';

class LinesSortDialog extends StatefulWidget {
  final List<BusLine> availableBusLines;

  const LinesSortDialog({Key? key, required this.availableBusLines})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LinesSortDialog();
}

class _LinesSortDialog extends State<LinesSortDialog> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.availableBusLines.length,
      itemBuilder: (context, index) {
        BusLine busLine = widget.availableBusLines[index];
        return ListTile(
          title: Text(
            busLine.name,
            style: TextStyle(
              color: AppColors.of(context).fontColor,
            ),
          ),
        );
      },
    );
  }
}
