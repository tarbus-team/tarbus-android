import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';
import 'package:tarbus_app/views/pages/departures_page/all_departures_tab/all_departures_tab.dart';
import 'package:tarbus_app/views/pages/departures_page/next_departures_tab/next_departures_tab.dart';
import 'package:tarbus_app/views/widgets/generic/keep_alive_page.dart';

class DeparturesPage extends StatefulWidget {
  final int busStopId;
  final String? busStopName;
  final BusLine? busLine;

  const DeparturesPage({
    Key? key,
    this.busStopName,
    required this.busStopId,
    this.busLine,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DeparturesPage();
}

class _DeparturesPage extends State<DeparturesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_tabController.index != 0) {
          _tabController.animateTo(0);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Rozkład jazdy',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 18),
            onPressed: () {
              context.router.pop();
            },
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.heart),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.info),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Column(
              children: [
                Center(
                  child: Text(
                    '${widget.busStopName}',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      text: 'Najbliższe',
                    ),
                    Tab(text: 'Wszystkie'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: _tabController,
            children: [
              KeepAlivePage(
                child: NextDeparturesTab(
                  busLine: widget.busLine,
                  busStopName: widget.busStopName,
                  busStopId: widget.busStopId,
                  parentTabController: _tabController,
                ),
              ),
              KeepAlivePage(
                child: AllDeparturesTab(
                  busLine: widget.busLine,
                  busStopName: widget.busStopName,
                  busStopId: widget.busStopId,
                  parentTabController: _tabController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// headerSliverBuilder: (context, innerBoxIsScrolled) {
// return [
// SliverOverlapAbsorber(
// handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
// sliver: SliverAppBar(
// actions: [
// IconButton(
// onPressed: () {},
// icon: Icon(CupertinoIcons.heart),
// ),
// IconButton(
// onPressed: () {},
// icon: Icon(Icons.info),
// ),
// ],
// expandedHeight: 130,
// title: Text(
// 'Rozkład jazdy',
// style: GoogleFonts.poppins(
// fontSize: 18,
// fontWeight: FontWeight.bold,
// color: Colors.black,
// ),
// ),
// leading: IconButton(
// icon: Icon(Icons.arrow_back_ios, size: 18),
// onPressed: () {
// context.router.pop();
// },
// ),
// floating: true,
// pinned: true,
// forceElevated: true,
// elevation: 2,
// bottom: PreferredSize(
// preferredSize: Size.fromHeight(80),
// child: Column(
// children: [
// AnimatedAppHeader(
// scrollController: _scrollController,
// busStopName: widget.busStopName!,
// ),

// ],
// ),
// ),
// ),
// ),
// ];
// },
