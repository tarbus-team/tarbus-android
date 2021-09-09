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
  bool isSearching = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    context.read<DeparturesCubit>().initNewView(initialFilter: widget.busLine);
    fetchView(null);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NotificationListener<ScrollUpdateNotification>(
          onNotification: onScrollNotification,
          child: Scrollbar(
            isAlwaysShown: false,
            child: CustomScrollView(
              key: PageStorageKey<String>('1st'),
              physics: ClampingScrollPhysics(),
              slivers: <Widget>[
                BlocBuilder<DeparturesCubit, DeparturesState>(
                  builder: (context, state) {
                    if (state is DeparturesLoaded) {
                      return _buildDeparturesList(state);
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return new ListTile(
                            title: Text('Ładowanie...'),
                          );
                        },
                        childCount: 1,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool onScrollNotification(ScrollUpdateNotification notification) {
    fetchView(notification);

    return true;
  }

  Widget _buildListItem(
      DeparturesLoaded state, int index, int departuresLength) {
    final departure = state.departures[index - 1];
    final currentDaysAhead = state.daysAhead[index - 1];
    final nextDaysAhead = state.daysAhead[index];

    return DepartureListItem(
      departure: departure,
      isBreakpoint:
          index < departuresLength - 1 && currentDaysAhead != nextDaysAhead,
      daysAhead: currentDaysAhead,
      nextDaysAhead: index < state.daysAhead.length ? nextDaysAhead : null,
    );
  }

  Widget _buildDeparturesList(DeparturesLoaded state) {
    final departuresLength = state.departures.length;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == 0) {
            return SortListItem(
              state: state,
              busStopId: widget.busStopId,
            );
          }
          if (index >= departuresLength) {
            if (index == departuresLength) return SizedBox();
            if (index == departuresLength + 1)
              return Container(
                height: 100,
                child: CenterLoadSpinner(),
              );
          }
          return _buildListItem(state, index, departuresLength);
        },
        childCount: (departuresLength + 2),
      ),
    );
  }

  Future<void> fetchView(ScrollUpdateNotification? notification) async {
    if (notification == null ||
        (!isSearching &&
            notification.metrics.extentAfter < 1500 &&
            widget.parentTabController.index == 0)) {
      isSearching = true;
      await context.read<DeparturesCubit>().getAll(busStopId: widget.busStopId);
      isSearching = false;
    }
  }
}
