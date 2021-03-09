import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';

class HeaderTitle extends StatelessWidget {
  final String title;
  final Function action;
  final String actionName;

  HeaderTitle({@required this.title, this.action, this.actionName = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Container(
        color: AppColors.instance(context).lightGrey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.margin_view_horizontally, vertical: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              if (actionName.isNotEmpty)
                Container(
                  child: ButtonTheme(
                    padding: EdgeInsets.all(0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 0,
                    height: 0,
                    child: FlatButton(
                      onPressed: action,
                      child: Text(
                        actionName,
                        style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.instance(context).homeLinkColor),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
