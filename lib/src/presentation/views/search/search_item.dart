import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/model/entity/bus_stop.dart';
import 'package:tarbus2021/src/presentation/views/schedule/factory_schedule_view.dart';

class SearchItem extends StatelessWidget {
  final BusStop busStop;

  const SearchItem({Key key, this.busStop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      color: AppColors.lightGrey,
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
                    busStop.destinations == null ? "-" : busStop.destinations,
                    maxLines: 2,
                    style: TextStyle(color: AppColors.gray, fontStyle: FontStyle.italic),
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