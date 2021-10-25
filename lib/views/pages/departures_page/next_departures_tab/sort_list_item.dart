import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/bloc/departures_cubit/departures_cubit.dart';

import 'lines_sort_dialog.dart';

class SortListItem extends StatelessWidget {
  final DeparturesLoaded state;
  final int busStopId;

  const SortListItem({
    Key? key,
    required this.state,
    required this.busStopId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
                height: 40,
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => LinesSortDialog(
                        availableBusLines: state.busLinesFromBusStop,
                      ),
                    );
                  },
                  icon: Icon(Icons.filter_list),
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
}
