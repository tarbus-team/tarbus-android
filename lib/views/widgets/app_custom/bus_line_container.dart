import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/config/app_icons.dart';

class BusLineContainer extends StatelessWidget {
  final String busLineName;

  const BusLineContainer({
    Key? key,
    required this.busLineName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppIcons.of(context).busStopIcon,
          SizedBox(
            width: 43,
            child: Text(
              busLineName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
