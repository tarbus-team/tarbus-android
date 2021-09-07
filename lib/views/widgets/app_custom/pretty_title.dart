import 'package:flutter/cupertino.dart';
import 'package:tarbus_app/config/app_colors.dart';

class PrettyTitle extends StatelessWidget {
  final double bigSize;

  final double? smallSize;

  final String title;
  final String? subTitle;

  const PrettyTitle({
    Key? key,
    required this.bigSize,
    this.smallSize,
    required this.title,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle widgetStyle =
        CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle;

    return RichText(
      text: TextSpan(
        text: title,
        style: widgetStyle.copyWith(
          fontSize: bigSize,
          color: AppColors.of(context).fontColor,
        ),
        children: [
          if (subTitle != null)
            TextSpan(
              text: ' $subTitle',
              style: widgetStyle.copyWith(
                fontSize: smallSize,
                color: AppColors.of(context).primaryColor,
              ),
            )
        ],
      ),
    );
  }
}
