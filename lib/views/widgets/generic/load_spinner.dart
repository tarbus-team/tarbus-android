import 'package:flutter/material.dart';

class LoadSpinner extends StatelessWidget {
  final double size;
  final double strokeWidth;

  const LoadSpinner({
    Key? key,
    this.size = 24.0,
    this.strokeWidth = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey[200],
          strokeWidth: strokeWidth,
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ));
  }
}
