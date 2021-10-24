import 'package:auto_route/auto_route.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';
import 'package:tarbus_app/views/pages/departures_page/all_departures_tab/all_departures_tab.dart';
import 'package:tarbus_app/views/widgets/app_bars/animated_app_header.dart';
import 'package:tarbus_app/views/widgets/favourite/fav_heart_bus_stop.dart';

import 'next_departures_tab/next_departures_tab.dart';

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
  late ScrollController _scrollController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _scrollController = new ScrollController();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedNestedScrollView(
        controller: _scrollController,
        onlyOneScrollInBody: true,
        physics: BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.start,
        pinnedHeaderSliverHeightBuilder: () {
          return 80;
        },
        headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 130,
            elevation: 0.5,
            forceElevated: true,
            title: Text(
              'Rozkład jazdy',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.of(context).headlineColor,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 18),
              onPressed: () {
                context.router.pop();
              },
            ),
            actions: [
              FavHeartBusStop(
                  busStop: BusStop(
                id: widget.busStopId,
                name: widget.busStopName!,
              )),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.info),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Column(
                children: [
                  AnimatedAppHeader(
                      scrollController: _scrollController,
                      busStopName: widget.busStopName!),
                  // TabBar(),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.of(context).primaryColor,
                    tabs: <Tab>[
                      Tab(
                        text: 'Najbliższe',
                      ),
                      Tab(
                        text: 'Wszystkie',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
        body: ExtendedTabBarView(
          controller: _tabController,
          children: <Widget>[
            NextDeparturesTab(
              busLine: widget.busLine,
              busStopName: widget.busStopName,
              busStopId: widget.busStopId,
              parentTabController: _tabController,
            ),
            AllDeparturesTab(
              busLine: widget.busLine,
              busStopName: widget.busStopName,
              busStopId: widget.busStopId,
              parentTabController: _tabController,
            ),
          ],
        ),
      ),
    );
  }
}
