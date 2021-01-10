import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/model/bus_line.dart';
import 'package:tarbus2021/src/views/bus_routes_view/bus_routes_view.dart';

class BusLineListItem extends StatelessWidget {
  final BusLine busLine;

  BusLineListItem({this.busLine});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) => BusRoutesView(busLine: busLine)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage("assets/icons/bus_w.png"),
              color: Colors.white,
              size: 22,
            ),
            Container(
              width: 14,
            ),
            Text(
              busLine.name,
              style: TextStyle(fontFamily: 'Asap', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
