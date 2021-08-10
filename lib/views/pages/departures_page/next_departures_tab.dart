import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus_app/bloc/departures_bloc/departures_cubit.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';
import 'package:tarbus_app/views/pages/departures_page/departure_list_item.dart';
import 'package:tarbus_app/views/widgets/generic/center_load_spinner.dart';
import 'package:tarbus_app/views/widgets/generic/multiple_select.dart';

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
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    context.read<DeparturesCubit>().initNewView(initialFilter: widget.busLine);
    fetchView();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<DeparturesCubit, DeparturesState>(
            builder: (context, state) {
              if (state is DeparturesLoaded) {
                return Scrollbar(
                  isAlwaysShown: false,
                  child: _buildDeparturesList(state),
                );
              }
              return CenterLoadSpinner();
            },
          ),
        ),
      ],
    );
  }

  bool onScrollNotification(ScrollEndNotification notification) {
    if (notification.metrics.extentAfter == 0 &&
        widget.parentTabController.index == 0) {
      print('reached bottom');
      fetchView();
    }

    return true;
  }

  Widget _buildDeparturesList(state) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: onScrollNotification,
      child: ListView.builder(
        itemCount: (state.departures.length + 2),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.lineFilters.isEmpty
                            ? 'Najbliższe odjazdy'
                            : 'Najbliższe dla linii',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        width: 40,
                        child: MultipleSelect<BusLine>(
                          hint: 'Wybierz linie',
                          items: state.busLinesFromBusStop,
                          popupItemBuilder: (context, item) {
                            return Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/icon_bus.svg',
                                    color: Colors.black,
                                    height: 20,
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          onChanged: (items) {
                            context
                                .read<DeparturesCubit>()
                                .setFilters(widget.busStopId, items);
                          },
                          dropdownBuilder: (context, item) {
                            return IconButton(
                              onPressed: null,
                              icon: Icon(Icons.filter_list),
                            );
                          },
                          selectedItems: state.lineFilters,
                          comparator: (a, b) {
                            return a.id == b.id;
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: state.lineFilters.isEmpty ? 0 : 40,
                    margin: EdgeInsets.only(
                      bottom: state.lineFilters.isEmpty ? 0 : 15,
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: state.lineFilters.map<Widget>((e) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Chip(
                            onDeleted: () {
                              context.read<DeparturesCubit>().deleteFilter(
                                    busStopId: widget.busStopId,
                                    busLine: e,
                                  );
                            },
                            label: Text(e.name),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }
          final departuresLength = state.departures.length;
          if (index >= departuresLength + 1) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return DepartureListItem(
            departure: state.departures[index - 1],
            isBreakpoint: index < departuresLength - 1 &&
                state.daysAhead[index - 1] != state.daysAhead[index],
            daysAhead: state.daysAhead[index - 1],
          );
        },
      ),
    );
  }

  void fetchView() {
    context.read<DeparturesCubit>().getAll(busStopId: widget.busStopId);
  }
}
