import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarbus2021/src/model/entity/bus_line.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/clear_button.dart';
import 'package:tarbus2021/src/presentation/views/bus_routes/bus_routes_view.dart';

class BusLineListItem extends StatelessWidget {
  final BusLine busLine;

  BusLineListItem({this.busLine});

  @override
  Widget build(BuildContext context) {
    return ClearButton(
      button: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) {
                return BusRoutesView(busLine: busLine);
              },
              transitionsBuilder: (context, animation1, animation2, child) {
                return FadeTransition(
                  opacity: animation1,
                  child: child,
                );
              },
              transitionDuration: Duration(milliseconds: 150),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/icon_bus.svg",
              color: Colors.white,
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
    );
  }
}
