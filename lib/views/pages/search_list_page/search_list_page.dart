import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/bloc/search_cubit/search_cubit.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';
import 'package:tarbus_app/views/pages/search_list_page/search_list_item_stop.dart';

class SearchListPage extends StatefulWidget {
  final Function(BusStop item)? onBusStopSelected;

  const SearchListPage({Key? key, this.onBusStopSelected}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchListPage();
}

class _SearchListPage extends State<SearchListPage> {
  Widget _buildBusStopsList(List<BusStop> stops) {
    return ListView.builder(
      itemCount: stops.length,
      itemBuilder: (context, index) {
        return SearchListItemStop(
          busStop: stops[index],
          onBusStopSelected: widget.onBusStopSelected ?? (item) {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: TextField(
          onChanged: (value) {
            context.read<SearchCubit>().searchBusStops(value);
          },
          cursorWidth: 2,
          autofocus: true,
          cursorColor: AppColors.of(context).primaryColor,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Szukaj',
            enabledBorder: InputBorder.none,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () {
            context.router.pop();
          },
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchFoundBusStops) {
            return _buildBusStopsList(state.busStops);
          }
          return Text('Initial');
        },
      ),
    );
  }
}
