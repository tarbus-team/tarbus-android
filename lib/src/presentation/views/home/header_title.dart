import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';

class HeaderTitle extends StatelessWidget {
  final title;
  final action;
  final String actionName;

  HeaderTitle({@required this.title, this.action, this.actionName = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
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
                      style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
