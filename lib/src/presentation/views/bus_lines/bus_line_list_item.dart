import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/model/entity/bus_line.dart';
import 'package:tarbus2021/src/presentation/views/bus_routes/bus_routes_view.dart';

class BusLineListItem extends StatelessWidget {
  final BusLine busLine;

  BusLineListItem({this.busLine});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: ButtonTheme(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minWidth: 0,
        height: 0,
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
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
