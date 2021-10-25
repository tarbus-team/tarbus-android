import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:tarbus_app/bloc/departures_cubit/departures_cubit.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/config/app_config.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';
import 'package:tarbus_app/data/model/schedule/company.dart';

class LinesSortDialog extends StatefulWidget {
  final List<BusLine> availableBusLines;

  const LinesSortDialog({Key? key, required this.availableBusLines})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LinesSortDialog();
}

class _LinesSortDialog extends State<LinesSortDialog>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  Set<Company> companies = Set<Company>();
  List<BusLine> selectedLines = List.empty(growable: true);

  @override
  void initState() {
    for (BusLine e in widget.availableBusLines) {
      companies.add(e.version.company);
    }
    _tabController = TabController(length: companies.length, vsync: this);
    var lines = context.read<DeparturesCubit>().busLineFilters;
    if (lines.isNotEmpty) {
      selectedLines = lines;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Filtruj linie',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: 18,
                    ),
              ),
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: companies
                .map((e) => Tab(
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://api.tarbus.pl/static/company/${e.id}/app_logo.png',
                            height: 25,
                            color: context
                                    .read<GetAppConfigUseCaseImpl>()
                                    .isDarkTheme
                                ? Colors.white
                                : null,
                            errorWidget: (context, url, error) {
                              return Text('Error');
                            },
                          ),
                          Text(e.name),
                        ],
                      ),
                    ))
                .toList(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 22, right: 22, top: 10),
            child: Text(
              'Linie odjeżdżające z tego przystanku',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: companies.map((e) {
                return ListView(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Wrap(
                          children: widget.availableBusLines
                              .where((line) => line.version.company == e)
                              .map((line) {
                        if (selectedLines.contains(line)) {
                          return SizedBox();
                        }
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedLines.add(line);
                              });
                            },
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Chip(
                                  label: Text(line.name),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                )));
                      }).toList()),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 22, right: 22, top: 10),
            child: Text(
              'Wybrane linie',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Wrap(
                      children: selectedLines
                          .map((line) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedLines.remove(line);
                                });
                              },
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Chip(
                                    avatar: Icon(
                                      Icons.close,
                                      size: 15,
                                    ),
                                    label: Text(line.name),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3),
                                  ))))
                          .toList()),
                ),
              ],
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  selectedLines.clear();
                });
              },
              child: Text(
                'Wyczyść'.toUpperCase(),
                style: TextStyle(
                  color: AppColors.of(context).primaryColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.router.pop();
                      },
                      child: Text('Anuluj'),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<DeparturesCubit>()
                            .setFilters(selectedLines);
                        context.router.pop();
                      },
                      child: Text('Filtruj'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
