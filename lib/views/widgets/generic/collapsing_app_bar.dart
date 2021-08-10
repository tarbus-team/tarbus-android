import 'package:flutter/material.dart';

typedef CollapsingAppBarBodyCreator = Widget Function(BuildContext context);

class CollapsingAppBarPage extends StatefulWidget {
  final String titleText;
  final CollapsingAppBarBodyCreator bodyCreator;

  CollapsingAppBarPage({
    Key? key,
    required this.titleText,
    required this.bodyCreator,
  }) : super(key: key);

  @override
  _CollapsingAppBarPageState createState() => _CollapsingAppBarPageState();
}

class _CollapsingAppBarPageState extends State<CollapsingAppBarPage> {
  static const _kExpandedHeight = 200.0;

  late ScrollController _scrollController;
  //Offset state <-------------------------------------
  double offset = 0.0;

  @override
  void initState() {
    super.initState();
    //print("init state is called");

    _scrollController = ScrollController() //keepScrollOffset: false removed
      ..addListener(() {
        setState(() {
          //<-----------------------------
          offset = _scrollController.offset;
          // force a refresh so the app bar can be updated
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: _createSliverAppBar,
      body: widget.bodyCreator(context),
    );
  }

  List<Widget> _createSliverAppBar(
      BuildContext context, bool innerBoxIsScrolled) {
    // change the icon color as the page scrolls
    print("_createSliverAppBar is called");
    var collapsePercent = _getAppBarCollapsePercent();
    int rgb = ((1.0 - collapsePercent) * 255).round();
    var color = Color.fromARGB(255, rgb, rgb, rgb);

    return <Widget>[
      SliverAppBar(
        expandedHeight: _kExpandedHeight,
        pinned: true,
        iconTheme: IconThemeData(color: color),
        title: Text(widget.titleText),
      )
    ];
  }

  double _getAppBarCollapsePercent() {
    if (!_scrollController.hasClients) {
      print("positions is ${_scrollController.positions.length}");
      return 0.0;
    }

    //print("offset is${_scrollController.offset} and positions is ${_scrollController.positions.length}");
    return (offset / (_kExpandedHeight - kToolbarHeight)).clamp(0.0, 1.0);
  }
}
