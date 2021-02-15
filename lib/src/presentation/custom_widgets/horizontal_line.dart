import 'package:flutter/cupertino.dart';
import 'package:tarbus2021/src/app/app_colors.dart';

class HorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.instance(context).lineColor,
      height: 1,
    );
  }
}
