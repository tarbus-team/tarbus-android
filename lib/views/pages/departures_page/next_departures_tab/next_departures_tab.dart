import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/bloc/departures_cubit/departures_cubit.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';
import 'package:tarbus_app/views/pages/departures_page/next_departures_tab/departure_list_item.dart';
import 'package:tarbus_app/views/pages/departures_page/next_departures_tab/sort_list_item.dart';
import 'package:tarbus_app/views/widgets/generic/center_load_spinner.dart';

class NextDeparturesTab extends StatefulWidget {
  final int busStopId;
  final String? busStopName;
  final BusLine? busLine;
  final TabController parentTabController;

  const NextDeparturesTab({
    Key? key,
    this.busStopName,
    required this.busStopId,
    required this.parentTabController,
    this.busLine,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NextDeparturesTab();
}

class _NextDeparturesTab extends State<NextDeparturesTab> {
  bool isSearching = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    context.read<DeparturesCubit>().initNewView(initialFilter: widget.busLine);
    context.read<DeparturesCubit>().getAll(busStopId: widget.busStopId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: false,
      child: BlocBuilder<DeparturesCubit, DeparturesState>(
        builder: (context, state) {
          if (state is DeparturesLoaded) {
            return _buildDeparturesList(state);
          }
          return Text('Ładowanie...');
        },
      ),
    );
  }

  bool onScrollNotification(ScrollUpdateNotification notification) {
    fetchView(notification);
    return true;
  }

  Widget _buildDeparturesList(DeparturesLoaded state) {
    final departuresLength = state.departures.length;

    return NotificationListener<ScrollUpdateNotification>(
      onNotification: onScrollNotification,
      child: RefreshIndicator(
        onRefresh: () async {
          context
              .read<DeparturesCubit>()
              .initDepartures(initialFilter: widget.busLine);
          await context
              .read<DeparturesCubit>()
              .getAll(busStopId: widget.busStopId);
          return Future.value(true);
        },
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: (departuresLength + 2),
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return SortListItem(
                state: state,
                busStopId: widget.busStopId,
              );
            }
            if (index == departuresLength + 1) {
              return Container(
                height: 70,
                child: CenterLoadSpinner(),
              );
            }
            return DepartureListItem(
              departureWrapper: state.departures[index - 1],
            );
          },
        ),
      ),
    );
  }

  Future<void> fetchView(ScrollUpdateNotification? notification) async {
    print(notification != null);
    if (!isSearching &&
        notification != null &&
        notification.metrics.extentAfter == 0 &&
        notification.metrics.maxScrollExtent != 0 &&
        widget.parentTabController.index == 0) {
      isSearching = true;
      await context.read<DeparturesCubit>().getAll(busStopId: widget.busStopId);
      isSearching = false;
    }
  }
}
