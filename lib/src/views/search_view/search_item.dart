import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/model/bus_stop.dart';
import 'package:tarbus2021/src/views/schedule_view/factory_schedule_view.dart';

class SearchItem extends StatelessWidget {
  final BusStop busStop;

  const SearchItem({Key key, this.busStop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      color: AppColors.lightgray,
      child: FlatButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FactoryScheduleView(busStop: busStop)));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.margin_view_horizontally, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                busStop.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, fontFamily: 'Asap'),
              ),
              Container(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.arrow_forward,
                    color: AppColors.primaryColor,
                  ),
                  Expanded(
                      child: Text(
                    busStop.parsedDestinations,
                    maxLines: 2,
                    style: TextStyle(color: AppColors.gray, fontFamily: 'Asap', fontStyle: FontStyle.italic),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
