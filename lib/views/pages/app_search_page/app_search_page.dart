import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/bloc/search_hint_cubit/search_hint_cubit.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';
import 'package:tarbus_app/views/widgets/app_bars/search_tab.dart';
import 'package:tarbus_app/views/widgets/generic/pretty_scroll_view.dart';

class AppSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppSearchPage();
}

class _AppSearchPage extends State<AppSearchPage> {
  @override
  void initState() {
    context.read<SearchHintCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrettyScrollView(
      subTitle: null,
      title: 'Szukaj',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                context.router.push(SearchListRoute(type: 'mix'));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Szukaj'),
                  ],
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(8, 25, 8, 10),
              child: Text(
                'Proponowane opcje'.toUpperCase(),
                style: Theme.of(context).textTheme.headline3,
              )),
          BlocBuilder<SearchHintCubit, SearchHintState>(
            builder: (context, state) {
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(4.0),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                children: [
                  SearchTab(
                    title: 'Przystanki',
                    type: SearchTabType.bus_stop,
                    isPrimary: true,
                    onTap: () {
                      context.router.push(SearchListRoute(type: 'bus_stop'));
                    },
                  ),
                  SearchTab(
                    title: 'Linie',
                    type: SearchTabType.bus_line,
                    isPrimary: true,
                    onTap: () {
                      context.router.push(SearchListRoute(type: 'bus_line'));
                    },
                  ),
                  if (state is SearchHintLoaded)
                    ...state.stops.map(
                      (e) => SearchTab(
                        onTap: () {
                          context.router.push(DeparturesRoute(
                              busStopId: e.id, busStopName: e.name));
                        },
                        titleWidget: BackdropFilter(
                          filter:
                              new ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                  color: Colors.white,
                                  fontSize: 10.5,
                                  shadows: <Shadow>[
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black87,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                e.destinations,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                  color: Colors.white,
                                  fontSize: 10,
                                  shadows: <Shadow>[
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black87,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Blisko Ciebie',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  fontSize: 18,
                                  shadows: <Shadow>[
                                    Shadow(
                                      blurRadius: 2.0,
                                      color: Colors.black87,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        type: SearchTabType.bus_line,
                        isPrimary: false,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
