import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus_app/bloc/departures_cubit/departures_cubit.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';
import 'package:tarbus_app/views/widgets/generic/multiple_select.dart';

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
                        .setFilters(busStopId, items);
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
                            busStopId: busStopId,
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
