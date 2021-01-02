import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final String label;
  final String text;

  const LegendItem(this.label, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          maxLines: 2,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text(
              text,
              maxLines: 3,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
