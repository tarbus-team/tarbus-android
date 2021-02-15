import 'package:flutter/cupertino.dart';

class ExtendedBanner extends StatelessWidget {
  final Widget child;
  final String message;
  final TextDirection textDirection;
  final BannerLocation location;
  final TextDirection layoutDirection;
  final Color color;
  final TextStyle textStyle;
  final bool isVisible;

  const ExtendedBanner(
      {Key key,
      @required this.message,
      this.textDirection,
      @required this.location,
      this.layoutDirection,
      this.color,
      this.textStyle,
      this.child,
      this.isVisible = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isVisible) {
      return Banner(
        message: message,
        location: location,
        child: child,
        //textDirection: textDirection,
        //layoutDirection: layoutDirection,
        color: color,
        //textStyle: textStyle,
      );
    } else {
      return child;
    }
  }
}
