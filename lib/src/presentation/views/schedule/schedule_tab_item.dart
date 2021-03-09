import 'package:flutter/cupertino.dart';

class ScheduleTabItem extends StatelessWidget {
  final String title;

  const ScheduleTabItem({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
