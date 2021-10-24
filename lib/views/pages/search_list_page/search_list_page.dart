import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/bloc/search_cubit/search_cubit.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';
import 'package:tarbus_app/views/pages/search_list_page/search_list_item_line.dart';
import 'package:tarbus_app/views/pages/search_list_page/search_list_item_stop.dart';

class SearchListPage extends StatefulWidget {
  final String type;
  final bool? wantsFavourite;

  const SearchListPage({Key? key, required this.type, this.wantsFavourite})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchListPage();
}

class _SearchListPage extends State<SearchListPage> {
  int buildCount = 0;
  @override
  void initState() {
    print(widget.wantsFavourite);
    context.read<SearchCubit>().search('', widget.type);
    super.initState();
  }

  Widget _buildResultList(List<dynamic> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        if (item is BusStop) {
          return SearchListItemStop(
            key: PageStorageKey('$buildCount-${item.id}'),
            busStop: item,
            wantsFavourite: widget.wantsFavourite ?? false,
          );
        }
        if (item is BusLine) {
          return SearchListItemLine(
            key: PageStorageKey('$buildCount-${item.id}'),
            busLine: item,
            wantsFavourite: widget.wantsFavourite ?? false,
          );
        }
        return Text('undefined');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    buildCount += 1;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: TextField(
          onChanged: (value) {
            context.read<SearchCubit>().search(value, widget.type);
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
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state is SearchRefresh) {
            setState(() {});
            print(buildCount);
          }
        },
        builder: (context, state) {
          if (state is SearchFound) {
            return _buildResultList(state.result);
          }
          return Text('Initial');
        },
      ),
    );
  }
}
