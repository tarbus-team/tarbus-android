import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/horizontal_line.dart';

class HomeButton extends StatelessWidget {
  final icon;
  final title;
  final onPressed;
  final image;

  HomeButton({this.icon, this.title, this.onPressed, this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FlatButton(
          onPressed: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (image != null)
                    ? ImageIcon(
                        image,
                        color: AppColors.primaryColor,
                        size: 30,
                      )
                    : Icon(
                        icon,
                        color: AppColors.primaryColor,
                        size: 30,
                      ),
                Container(
                  width: 20,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
        ),
        HorizontalLine(),
      ],
    );
  }
}
