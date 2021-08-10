import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedAppHeader extends StatefulWidget {
  final ScrollController scrollController;
  final String busStopName;

  const AnimatedAppHeader(
      {Key? key, required this.scrollController, required this.busStopName})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _AnimatedAppHeader();
}

class _AnimatedAppHeader extends State<AnimatedAppHeader> {
  bool isCollapsed = false;

  @override
  void initState() {
    widget.scrollController.addListener(() {
      if (widget.scrollController.offset == 50) {
        setState(() {
          isCollapsed = true;
        });
      } else if (widget.scrollController.offset < 40 && isCollapsed) {
        setState(() {
          isCollapsed = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      height: 32,
      color: !isCollapsed ? Colors.white : Theme.of(context).primaryColor,
      duration: Duration(milliseconds: 250),
      child: Center(
        child: Text(
          widget.busStopName,
          style: Theme.of(context).textTheme.headline3!.copyWith(
              fontFamily: 'Roboto',
              fontSize: 14,
              color: !isCollapsed ? Colors.black : Colors.white),
        ),
      ),
    );
  }
}
